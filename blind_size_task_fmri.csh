#!/bin/tcsh -xef

# assign input variables
if ( $#argv == 1 ) then
    set subj = $argv[1]
else
    echo "Please set subject & session ID as input variables"
endif

set top_dir = /home/jaco-raid8/sponheim-data/SYON/analysis/
set subj_dir = {$top_dir}{$subj}/glm/
set save_dir = /home/jaco-raid9/schallmo/SYON/saved_size_codes/

@ count = 1
set use_idx = (`shuf -i 1-4`)

foreach idx ( $use_idx )
    if ( {$count} == 1 ) then # UL Hall
        3dcopy {$subj_dir}sizeHall_UL+orig {$subj_dir}sizeCond${idx}+orig
        unlink {$subj_dir}sizeHall_UL+orig
        echo ${idx} > {$save_dir}{$subj}_sizeHall_UL.txt

    else if ( {$count} == 2 ) then # LL Hall
        3dcopy {$subj_dir}sizeHall_LL+orig {$subj_dir}sizeCond${idx}+orig
        unlink {$subj_dir}sizeHall_LL+orig
        echo ${idx} > {$save_dir}{$subj}_sizeHall_LL.txt

    else if ( {$count} == 3 ) then # UL No Hall
        3dcopy {$subj_dir}sizeNoHall_UL+orig {$subj_dir}sizeCond${idx}+orig
        unlink {$subj_dir}sizeNoHall_UL+orig
        echo ${idx} > {$save_dir}{$subj}_sizeNoHall_UL.txt

    else if ( {$count} == 4 ) then # LL No Hall
        3dcopy {$subj_dir}sizeNoHall_LL+orig {$subj_dir}sizeCond${idx}+orig
        unlink {$subj_dir}sizeNoHall_UL+orig
        echo ${idx} > {$save_dir}{$subj}_sizeNoHall_LL.txt

    endif
    3drefit -denote {$subj_dir}sizeCond${idx}+orig
    @ count += 1
end

chgrp phcp {$save_dir}{$subj}*.txt
chmod 700 {$save_dir}{$subj}*.txt
chown schallmo {$save_dir}{$subj}*.txt