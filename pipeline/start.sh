#!/bin/bash

BASEDIR=$(dirname "$0")
cd $BASEDIR

sbatch --partition=highmem --job-name=variantannot --error=%x.%J.err --output=%x.%J.out invoke_commands.sh; 
