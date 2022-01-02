#!/bin/bash

cd /tmp/rom
. build/envsetup.sh
lunch lineage_merlinx-userdebug
export CCACHE_DIR=/tmp/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
export TZ=UTC
ccache -M 50G
ccache -o compression=true
ccache -z

make(){
    mka bacon
	zip=$(upload out/target/product/merlinx/*zip)
	echo " "
	echo "$zip"
}

upload(){
        curl --upload-file $1 https://transfer.sh/ 
}

make &
sleep 5200 && kill "$!"
ccache -s