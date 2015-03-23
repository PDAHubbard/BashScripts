#!/bin/sh

#
# Set the mplayer environment variables (change for your configuration)
#
LD_LIBRARY_PATH=/local/usr/lib; export LD_LIBRARY_PATH
PATH=/local/usr/bin:${PATH}; export PATH

#
# Change to match AVS/Express viewer dimensions
# The dimensions must be divisible by 16
#
width=720
height=576

#
# Compute the optimal bitrate 
#	br = 50 * 25 * width * height / 256
#
# the 50 factor can vary between 40 and 60
#
obr=`expr $width \* $height \* 50 \* 25 / 256`

#
# set the MPEG4 codec options
#
#opt="vbitrate=$obr:mbd=2:keyint=132:v4mv:vqmin=3:lumi_mask=0.07:dark_mask=0.2:scplx_mask=0.1:tcplx_mask=0.1:naq:trell"
#codec="mpeg4"

#
# set the Microsoft MPEG4 V2 codec options
#
opt="vbitrate=$obr:mbd=2:keyint=132:vqblur=1.0:cmp=2:subcmp=2:dia=2:mv0:last_pred=3"
codec="msmpeg4v2"

#
# clean temporary files that can interfere with the compression phase
#
rm -f divx2pass.log frameno.avi

#
# compress
#
mencoder -ovc lavc -lavcopts vcodec=$codec:vpass=1:$opt -nosound -o /dev/null  avs.avi
mencoder -ovc lavc -lavcopts vcodec=$codec:vpass=2:$opt -nosound -o output.avi avs.avi

#
# cleanup
#
rm -f divx2pass.log
