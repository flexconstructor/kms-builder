#!/usr/bin/env bash

mkdir -p /.kms/build_$TYPE/ \
&& cd /.kms/build_$TYPE/ \
&& cmake -DCMAKE_BUILD_TYPE=$TYPE \
         -DENABLE_ANALYZER_ASAN=ON \
         -DSANITIZE_ADDRESS=ON \
         -DSANITIZE_THREAD=ON \
         -DSANITIZE_LINK_STATIC=ON \
       .. \
&& make
