#!/bin/bash

cd /tmp

# Compress function with pigz for faster compression
com () 
{ 
    tar --use-compress-program="pigz -k -$2 " -cf $1.tar.gz ccache
}

time com ccache 1 # Compression level 1, its enough
mkdir -p ~/.config/rclone
echo "$rclone_config" > ~/.config/rclone/rclone.conf # Write rclone config found from env variable, so that cloud storage can be used to upload ccache
time rclone copy ccache.tar.gz drive:ccache -P