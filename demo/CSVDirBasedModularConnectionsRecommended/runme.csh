#!/bin/csh -f

set currd=$PWD
cd ../../../
source setup_env.csh
cd $currd

baya-shell -f build.tcl

