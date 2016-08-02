#!/bin/bash

for f in `find $1 -name '*'`
do
   filename=`echo $f|awk -F'/' '{SL = NF-1; TL = NF-2; print $SL "." $NF}'`
   cp -L $f $2/$filename
done

for file in $2/*.pem ; do mv $file ${file//privkey/key} ; done
