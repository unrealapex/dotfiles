#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#e5dbd9/g' \
         -e 's/rgb(100%,100%,100%)/#000000/g' \
    -e 's/rgb(50%,0%,0%)/#000000/g' \
     -e 's/rgb(0%,50%,0%)/#612d32/g' \
 -e 's/rgb(0%,50.196078%,0%)/#612d32/g' \
     -e 's/rgb(50%,0%,50%)/#fbf4f1/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#fbf4f1/g' \
     -e 's/rgb(0%,0%,50%)/#000000/g' \
	"$@"