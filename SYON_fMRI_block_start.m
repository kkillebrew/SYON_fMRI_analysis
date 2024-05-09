function out = SYON_fMRI_block_start

% Total times are: 
out.ill.total_time = 250; % sec, for illusory contour and SSVEP
out.ss.total_time = 250; % sec, for illusory contour and SSVEP
out.gam.total_time = 210; % sec, for gamma
% All the timing info (total time, block start times, flip times expected, flip times recorded, recorded trigger times, etc.) can be found for any subject in their data file in the struct 'options.time'.

% For the SSVEP and Illusory Contour the block start times are: 
block_start_ill = [0    10    20    30    40    50    60    70    80    90   100   110   120   130   140   150   160   170   180   190   200   210   220   230   240]; 
% where the block type indices are: 
block_idx_ill = [3     1     2     1     2     1     3     2     1     2     1     2     3     1     2     1     2     1     3     2     1     2     1     2     3]; 
% (where 3=blank; 2=Surround/Contours ; 1=Center/Inducers).

% For the gamma the block start times are: 
block_start_gam = [0    10    20    30    40    50    60    70    80    90   100   110   120   130   140   150   160   170   180   190   200]; 
% where the block type indices are: 
block_idx_gam = [2     1     2     1     2     1     2     1     2     1     2     1     2     1     2     1     2     1     2     1     2];
% (where 2=blank; 1=circle).

out.TR = 0.8; % sec

out.ill.total_TR = round(total_time_ill ./ out.TR);
out.ill.block_TR_all = round(block_start_ill ./ out.TR)+1; % divide by out.TR then add 1 to start counting from 1 not 0
out.ill.block_TR_inducer = out.ill.block_TR_all( block_idx_ill == 1 ); % TRs where this condition starts, for use as regressors
out.ill.block_TR_contour = out.ill.block_TR_all( block_idx_ill == 2 ); % TRs where this condition starts, for use as regressors
out.ill.block_TR_blank = out.ill.block_TR_all( block_idx_ill == 3 ); % TRs where this condition starts, for use as regressors

out.ss.total_TR = out.ill.total_TR;
out.ss.block_TR_all = out.ill.block_TR_all;
out.ss.block_TR_center = out.ill.block_TR_inducer; % TRs where this condition starts, for use as regressors
out.ss.block_TR_surround = out.ill.block_TR_contour; % TRs where this condition starts, for use as regressors
out.ss.block_TR_blank = out.ill.block_TR_blank;

out.gam.total_TR = round(total_time_gam ./ out.TR);
out.gam.block_TR_all = round(block_start_gam ./ out.TR)+1; % divide by out.TR then add 1 to start counting from 1 not 0
out.gam.block_TR_circle = out.gam.block_TR_all( block_idx_gam == 1 ); % TRs where this condition starts, for use as regressors
out.gam.block_TR_blank = out.gam.block_TR_all( block_idx_gam == 2 ); % TRs where this condition starts, for use as regressors

end