#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#e4d0fc/g' \
         -e 's/rgb(100%,100%,100%)/#000000/g' \
    -e 's/rgb(50%,0%,0%)/#000000/g' \
     -e 's/rgb(0%,50%,0%)/#382a9c/g' \
 -e 's/rgb(0%,50.196078%,0%)/#382a9c/g' \
     -e 's/rgb(50%,0%,50%)/#f4f1ff/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#f4f1ff/g' \
     -e 's/rgb(0%,0%,50%)/#000000/g' \
	"$@"