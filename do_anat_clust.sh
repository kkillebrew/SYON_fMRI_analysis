#!/bin/tcsh -xef

# mps 20200903

# the user may specify a single subject to run with
if ( $#argv > 0 ) then
    set subj = $argv[1]
else
    echo "Please set subject ID as input variable"
    exit
endif

set top_dir = /home/jaco-raid8/sponheim-data/SYON
set analysis_dir = {$top_dir}/analysis/{$subj}
set proc_dir = {$top_dir}/fMRI_preproc/{$subj}/preproc_data

cd {$analysis_dir}

# first make anatomical ROIs from Kastner atlas using minn.py
minn.py getKastnerROIs -a {$analysis_dir}/anat/anat_SurfVol.nii.gz

# pull out V1 only, because it seems like this is the most trustworthy
3dcalc -overwrite                         \
    -prefix {$analysis_dir}/vol/V1.nii.gz \
    -a {$analysis_dir}/vol/kastner.nii.gz \
    -expr 'equals(a,1)'

# median filter to reduce noise / patchy-ness
3dMedianFilter -overwrite -prefix {$analysis_dir}/vol/V1.nii.gz -irad 1 {$analysis_dir}/vol/V1.nii.gz

# link
ln -s {$analysis_dir}/vol/V1.nii.gz {$analysis_dir}/fourier/V1.nii.gz
ln -s {$analysis_dir}/vol/V1.nii.gz {$analysis_dir}/glm/V1.nii.gz

foreach task ( 'wedges' 'rings' )
    # apply stats to fourier analysis coherence data
    3dcalc -overwrite -prefix {$analysis_dir}/fourier/rm_{$task}_F.nii.gz \
        -a "${analysis_dir}/fourier/${task}.nii.gz[1]" -expr 'a*119 / (1 - a)'
    # This is the F-value for the coherence metric, according to the equation: 
    # Fval = C2*(df/2 - 1) / (1 - C2)
    # df = 2*L
    # L = # of frequency bands in my FFT (i.e., n data points / 2)

    # Append the masked F-stat data to the file
    3dTcat -overwrite -prefix {$analysis_dir}/fourier/{$task}.nii.gz \
        {$analysis_dir}/fourier/{$task}.nii.gz"[0..2]"               \
        {$analysis_dir}/fourier/rm_{$task}_F.nii.gz

    # Tell AFNI this is an F statistic
    3drefit -substatpar 3 fift 2 238 {$analysis_dir}/fourier/{$task}.nii.gz
    # this says sub-block = 3, stat type = fift = F-value, df1 = 2, df2 = 238
    # df2 = 2*L-2
    # see also mpsCoherenceSig.m

    if $task == 'wedges' then
        set scan_name = 'retCW'
    else if $task == 'rings' then
        set scan_name = 'retExp'
    else
        echo 'error: unknown task name $task'
    endif

    # Add in the information we need for clusterwise p-value correction
    ln -s {$proc_dir}/files_ClustSim/ {$analysis_dir}/fourier/files_ClustSim

    ln -s {$proc_dir}/3dClustSim.ACF.{$scan_name}.cmd         \
        {$analysis_dir}/fourier/3dClustSim.ACF.{$scan_name}.cmd

end

\rm -f {$analysis_dir}/fourier/rm*.nii.gz