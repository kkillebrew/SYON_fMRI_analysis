#!/bin/bash
renice 19 -p $$
date
export OMP_NUM_THREADS=8
maindir=/home/jaco-raid8/sponheim-data/SYON # mps 20210304
HCPdir=$maindir/FreeSurfer # mps 20210304
subdir=$HCPdir
HCP_SCRIPTS=/home/jaco-raid8/sponheim-data/SYON/SYON_fMRI_analysis.git/HCP_pipeline # mps 20210304
#echo  ${HCP_SCRIPTS}/SetUpHCPPipeline.sh
source ${HCP_SCRIPTS}/SetUpHCPPipeline.sh
#niidir=$maindir/QA/dMRI/NII
niidir=$maindir/fMRI_preproc
# this is where the input data live # mps 20210304

scriptdir=/opt/local/hcp-pipelines-3.22.0/Pipelines-3.22.0
for proc in `cd $niidir ; ls -d * |grep pilot_2` ; do
    # pull in a list of subjects folders, currently set to only look at pilot_2, replace * with S* and remove |grep...
    # mps 20210304

#for proc in `cd $niidir ; ls -d PHCP* ` ; do
#for proc in `cd $niidir ; ls -d PHCP* |grep PHCPP1010063` ; do
#proc=$1
#  echo $proc
  if [ ! -e $subdir/$proc/T1w ] ; then
    # if there is no FreeSurfer/subj#/T1w folder, then do processing # mps 20210304
    mkdir  $subdir/$proc
    cd $scriptdir/PreFreeSurfer
#    PreFreeSurferPipeline.sh --path=$subdir --subject=$proc --t1=t1.nii.gz --t2=t2.nii.gz
    converted_dir = $niidir/$proc/converted_data # mps 20210304
    echo PreFreeSurferPipeline.sh --path=$subdir --subject=$proc --t1=$converted_dir/T1w_MPR.nii.gz --t2=$converted_dir/T2w_SPC.nii.gz \
    --t1template=${HCPPIPEDIR_Templates}/MNI152_T1_0.7mm.nii.gz \
    --t1templatebrain=${HCPPIPEDIR_Templates}/MNI152_T1_0.7mm_brain.nii.gz \
    --templatemask=${HCPPIPEDIR_Templates}/MNI152_T1_0.7mm_brain_mask.nii.gz \
    --gdcoeffs=/home/shaw-raid1/sponheim-data/python_tools/gradunwarp-1.0.3/coef/3TB_coeff_from_scanner_20200306.grad
    PreFreeSurferPipeline.sh --path=$subdir --subject=$proc --t1=$converted_dir/T1w_MPR.nii.gz --t2=$converted_dir/T2w_SPC.nii.gz \
    --t1template=${HCPPIPEDIR_Templates}/MNI152_T1_0.7mm.nii.gz \
    --t1templatebrain=${HCPPIPEDIR_Templates}/MNI152_T1_0.7mm_brain.nii.gz \
    --templatemask=${HCPPIPEDIR_Templates}/MNI152_T1_0.7mm_brain_mask.nii.gz \
    --gdcoeffs=/home/shaw-raid1/sponheim-data/python_tools/gradunwarp-1.0.3/coef/3TB_coeff_from_scanner_20200306.grad

    cd ${HCP_SCRIPTS}
    FreeSurferPipelineBatch_SYON.sh --Subjlist="$proc"
    PostFreeSurferPipelineBatch_SYON.sh --Subjlist="$proc"
    #chmod -R 770 $subdir/$proc/T1w $subdir/$proc/T2w $subdir/$proc/MNINonLinear
    chmod -R 770 $subdir/$proc
    chown -R schallmo:phcp $subdir/$proc # mps 20210304
#  else
#    echo PreFreeSurferPipeline.sh run on $subdir/$proc
  fi
done

