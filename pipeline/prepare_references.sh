#!/bin/bash

source /cmmr/prod/envParams/condaenv.init; conda activate  variantannot; 

export reflist=$1
export refdir=$2
export snpEffConf=$3 

cat $reflist | cut -f2 | sort | uniq | parallel -j1 -I {} 'name=`echo {} | cut -f1`; \
cd ${refdir}/${name}; \
snpEff build -v -c ${snpEffConf} -genbank -v ${name} >> ${refdir}/${name}.snpEff.log 2>&1; \
cp ${name}.fasta sequences.fa; \
cp ${name}.gbk genes.gbk;'
