#!/bin/bash

#################################################################
# Script to select a random wallpaper in GNOME 2      #
#                        #
# Selects images from the previously selected wallpapers,   #
# and from a desired folder. Its path should be configured    #
# in line 31, along with desired image extension       #
#                        #
# The script also selects the rendering method for the image   #
# This feature uses the command "identify", from ImageMagick   #
# Also, check if your distro is using gconftool or gconftool-2   #
# Change this option in lines 50, 52 and 56         #
#                        #
# The Delay between images is set in seconds, in line 62   #
#                        #
# Create an entry to this script in your "Startup Applications"   #
# to execute it in every gnome session start. The command would   #
# be:                        #
#    PathToScript/background.sh &            #
# The & would run the script as a background process      #
#################################################################

# Begin of infinite loop [condition always true]
while [ 1 == 1 ] ; do

# Create array with the filenames of the previously selected wallpapers,
# from the information in the file "~/.gnome2/backgrounds.xml"
# ALIST=( `grep filename ~/.gnome2/backgrounds.xml | sed 's/<filename>//g' | sed 's/<\/filename>//g'` )

# Add to this array the filenames of images '*.JPG' in "$HOME/DATA/Pictures"
# folder. Additional folders could be added with the same syntax
ALIST=( "${ALIST[@]}" `find /home/skallagrigg/Pictures/wallpapers/ -name '*.jpg'` )

# Obtain the number of elements in this array
RANGE=${#ALIST[@]}

# Select randomly one of these elements
let "number = $RANDOM % $RANGE"

# Obtain the width and height of the image
xIMG=`identify -format "%[fx:w]" ${ALIST[$number]}` #Width
yIMG=`identify -format "%[fx:h]" ${ALIST[$number]}` #Height

# Compares the Width and Height, to select the rendering option of the image
# If Width > Height, select "zoom"
# Else, select "scaled"
# Possible values: "none", "wallpaper", "centered", "scaled", "stretched", "zoom", "spanned"
if [ "$xIMG" -gt "$yIMG" ] ; then
  gconftool -t string -s /desktop/gnome/background/picture_options zoom
else
  gconftool -t string -s /desktop/gnome/background/picture_options scaled
fi

# Set the random filename as wallpaper image
gconftool -t string -s /desktop/gnome/background/picture_filename ${ALIST[$number]}

# Pause in the script, in seconds. The time the image will remain as wallpaper
# 60   =  1 minute
# 300  =  5 minutes
# 1800 = 30 minutes
sleep 300

# Continue loop
done
