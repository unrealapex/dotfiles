#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#fbe4d3/g' \
         -e 's/rgb(100%,100%,100%)/#000000/g' \
    -e 's/rgb(50%,0%,0%)/#000000/g' \
     -e 's/rgb(0%,50%,0%)/#854c67/g' \
 -e 's/rgb(0%,50.196078%,0%)/#854c67/g' \
     -e 's/rgb(50%,0%,50%)/#fffff0/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#fffff0/g' \
     -e 's/rgb(0%,0%,50%)/#000000/g' \
	"$@"