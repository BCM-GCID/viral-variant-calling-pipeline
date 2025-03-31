#!/bin/bash

source /cmmr/prod/envParams/condaenv.init; conda activate  variantannot; snakemake -j40;
