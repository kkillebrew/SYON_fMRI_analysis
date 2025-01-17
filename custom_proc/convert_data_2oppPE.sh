# HM creating to handle cases with 2 oppPE scans 20230221; commenting out first 2 commands - redundant with SOP

# mkdir -p /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data

# cp -r /home/naxos/dicom/YYYYMMDD-ST001-SYONSXXXXXXX/* /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/.
# dicom data need to be moved off of naxos, not permanent storage
# 1 dicom data set = ~4.8 GB

mkdir -p /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data

to3d -prefix T1w_MPR.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE012-T1w_MPR_vNav_4e_RMS/*.dcm
# there are 4 dicom folders for this t1, 1st 2 have 4 echo times & 832 .dcm files, 2nd 2 (RMS) are combined, 
# down to 208 .dcm files (for both). LET'S START WITH THE 4TH assuming it's what we want...
# may need to come back and fix this once we figure out what data FreeSurfer wants...

to3d -prefix T2w_SPC.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE016-T2w_SPC_vNav/*.dcm
# there are 2 dicom folders for this t2, both have only 208 .dcm files.
# LET'S START WITH THE 2ND again, assuming it's what we want...
# Are these possibly with & without automatic distortion compensation??
# may need to come back and fix this once we figure out what data FreeSurfer wants...

to3d -prefix oppPE.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 3 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE019-GE_fMRI_oppPE_PA/*.dcm
# 3 folders for this, don't want physio log, don't want SBRef, SO USE 3RD
# time:zt is needed for functional data, 72 is # slices, 3 is # TRs

# HM 20230221 - Adding 2nd oppPE, will always need to update SE0XX to appropriate scan file number
to3d -prefix oppPE_2.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 3 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE0XX-GE_fMRI_oppPE_PA/*.dcm
# time:zt is needed for functional data, 72 is # slices, 3 is # TRs
 
to3d -prefix retCW.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 255 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE021-GE_fMRI_retCW_AP/*.dcm
 
to3d -prefix retCCW.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 255 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE024-GE_fMRI_retCCW_AP/*.dcm
 
to3d -prefix gamLoc.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 263 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE027-GE_fMRI_gamLoc_AP/*.dcm
 
to3d -prefix ssLoc.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 313 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE030-GE_fMRI_ssLoc_AP/*.dcm

to3d -prefix illLoc.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 313 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE033-GE_fMRI_illLoc_AP/*.dcm
 
# HM adding to3d lines for sizeHall_UR/L and sizeNoHall_UR/L 20210429
to3d -prefix sizeHall_LL.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 163 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE036-GE_fMRI_sizeHall_LL_AP/*.dcm

to3d -prefix sizeHall_UL.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 163 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE039-GE_fMRI_sizeHall_UL_AP/*.dcm

to3d -prefix sizeNoHall_LL.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 163 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE042-GE_fMRI_sizeNoHall_LL_AP/*.dcm

to3d -prefix sizeNoHall_UL.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 163 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE045-GE_fMRI_sizeNoHall_UL_AP/*.dcm

to3d -prefix LOCLoc.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 255 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE048-GE_fMRI_LOCLoc_AP/*.dcm

to3d -prefix MTLoc.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 255 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE051-GE_fMRI_MTLoc_AP/*.dcm

to3d -prefix retExp.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data -time:zt 72 255 0 FROM_IMAGE /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE054-GE_fMRI_retExp_AP/*.dcm

to3d -prefix b0_mag.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE056-gre_field_mapping_2mm/*-EC*.dcm

to3d -prefix b0_ph.nii.gz -session /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/converted_data /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE057-gre_field_mapping_2mm/*-EC*.dcm

# takes about 7 min to run to completion


# come back later and implement HCP anatomical processing pipeline
# for now, just try Free Surfer recon-all so we have something to work with...
recon-all                                                                                                                      \
  -i /home/jaco-raid8/sponheim-data/SYON/fMRI_preproc/SXXXXXXX/dicom_data/MR-SE012-T1w_MPR_vNav_4e_RMS/MR-ST001-SE012-0001.dcm \
  -s SXXXXXXX                                                                                                                  \
  -sd /home/jaco-raid8/sponheim-data/SYON/FreeSurfer                                                                           \
  -all
# takes about 6 hours
# using FreeSurfer v5.3 right now...

# run @SUMA_Make_Spec_FS
@SUMA_Make_Spec_FS -fspath /home/jaco-raid8/sponheim-data/SYON/FreeSurfer/SXXXXXXX -sid anat
# takes about 8 min

# make a .nii.gz version of the SurfVol
3dcopy /home/jaco-raid8/sponheim-data/SYON/FreeSurfer/SXXXXXXX/SUMA/anat_SurfVol+orig /home/jaco-raid8/sponheim-data/SYON/FreeSurfer/SXXXXXXX/SUMA/anat_SurfVol.nii.gz
