To activate conda env: 

source /cmmr/prod/envParams/condaenv.init; conda activate  variantannot;

Setting up reference for ivar:

- Download genbank, fasta and gff3 records from NCBI for reference sequence.

- Place fasta and gff3 in this folder /gpfs1/db/viralRefGenomes/bwa/<genbank accession>/

- Edit fasta to have only the accession number in the header.

- cd into the above folder and build the BWA index: bwa index reference.fasta

Setting up reference for snpEff:
Building snpEff DB: https://pcingola.github.io/SnpEff/se_buildingdb/

- create a new folder for to hold the database: /cmmr/opt/miniconda3/envs/variantannot/share/snpeff-5.0-1/data/AB365435.1

- when downloading genbank file from ncbi do not check the "Show GI" box. This will mess up the snpEff annotations.

- copy genbank file to the above folder and rename it as genes.gbk

- add following entry to /cmmr/opt/miniconda3/envs/variantannot/share/snpeff-5.0-1/snpEff.config

- AB365435.1.genome : Norovirus Hu/Texas/TCH04-577/2004/US genomic RNA, complete genome

- run: snpEff build -genbank -v AB365435.1
