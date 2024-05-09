#!/bin/tcsh -ef

#
# SetUpFreeSurfer.csh
#

# This is a sample SetUpFreeSurfer.csh file. 
# Edit as needed for your specific setup.  
# The defaults should work with most installations.

# Set this to the location of the freesurfer installation.
setenv FREESURFER_HOME /opt/local/hcp-5.3.0/freesurfer
#echo $FREESURFER_HOME
 
# Set this to your subjects/ dir, usually freesurfer/subjects/
if (! $?SUBJECTS_DIR) then
    setenv SUBJECTS_DIR /home/jaco-raid8/sponheim-data/SYON/FreeSurfer
endif

# Set this to your functional sessions dir, usually freesurfer/sessions/
if (! $?FUNCTIONALS_DIR) then
    setenv FUNCTIONALS_DIR $FREESURFER_HOME/sessions
endif

# Specify the location of the MINC tools.
# Necessary only if the script $FREESURFER_HOME/FreeSurferEnv.csh
# does not find the tools (and issues warnings pertaining to
# the following two environment variables, which have example
# locations that might need user-specific modification):
#setenv MINC_BIN_DIR /usr/pubsw/packages/mni/current/bin
#setenv MINC_LIB_DIR /usr/pubsw/packages/mni/current/lib

#setenv MINC_LIB_DIR /opt/bliss/freesurfer-4.2.0/mni/bin/
# ... or just disable the MINC toolkit (although some Freesurfer
# utilities will fail!) 
#setenv NO_MINC

# Enable or disable fsfast (enabled by default)
#setenv NO_FSFAST

# Call configuration script:
source $FREESURFER_HOME/SetUpFreeSurfer.sh
