<h1>Viral Variant Calling Pipeline</h1>

## Reference Genome Setup

#### Setup reference genome mapping file: 

Tab delimited file to provide a list of samples and references against which the variant calling needs to be performed

- This file has two columns without headers

    - First column – sample that is being investigated for variants

    - Second column – genbank accession of the reference

  ![image](https://github.com/user-attachments/assets/b5872eba-6f6f-4b46-94f9-b09cfed022e3)


#### Setup folder for references: 

Folder to hold reference genome files

- Create an individual folder for each reference. Folder name must be the genbank accession number. 

  ![image](https://github.com/user-attachments/assets/a5f13955-3f11-48db-a24c-d6705df4f96d)

- For each reference, download genbank, fasta and gff3 records from NCBI

- Place them in respective folders. 

- Reference fasta – file name must be in this format  *<accession>.fasta* and fasta header contains only the accession number. 

  ![image](https://github.com/user-attachments/assets/92626fa8-8bdd-4e17-911c-2914ca9a1f62)

- Reference genbank file – file name must be in this format *<accession>.gbk*
  
  ![image](https://github.com/user-attachments/assets/b1eddee0-27cc-49be-80b4-ad7f34c01f6a)

- Reference gff3 file – file name must be in this format *<accession>.gff3*
  
#### Setup snpEff.config file:

This file is locate in pipeline folder and overrides snpEff’s default configuration. 

- Open snpEff.config file and set data.dir value reference folder’s absolute path. 

  ![image](https://github.com/user-attachments/assets/9731010e-a8e0-47bd-ae19-2c698a7727b0)

- Add reference genome entries at the end of the file in the following format:

  *\<LOCUS\>.genome : \<DEFINITION\>* where LOCUS and DEFINITION values are retrieve from gbk file

  ![image](https://github.com/user-attachments/assets/d3114708-fd1b-4a62-b7be-9c8935d52fff)

#### Execute *prepare_references.sh*

This file is located in pipeline folder and runs snpEff build command on each of the references

`./prepare_references.sh <reference mapping file> <reference folder> snpEff.config`

- Outputs 3 files for each reference:

    - genes.gbk

    - sequences.fa

    - snpEffectPredictor.bin

  ![image](https://github.com/user-attachments/assets/731066f3-a82e-410a-a439-89c6cd13264a)


- Build command logs are located in reference folder *<accession>.snpEff.log*

- Verify logs for errors before proceeding with variant calling. 


### Variant Calling

#### Setup pipeline’s config.yml

- Read files: Paths to R1 and R2 files of final mapped reads output by VirMap.

    - *fastq1: "/path/to/final/reads/dir/{sample}/{sample}.final.1.fq.bz2"*
      
	  - *fastq2: "/path/to/final/reads/dir/{sample}/{sample}.final.1.fq.bz2"*

- Input directory: Top level directory where read files are present. 

    - *inputDir: "/path/to/final/reads/dir"*

- Output directory: Path to output directory where variant files are saved.

    - *outputDir: "/path/to/variant/calling/output/dir/{sample}"*

- Reference genome mapping file: Path to two column reference mapping file. 

    - *samplefile: "refgenome_mapping"*

- Reference genome folder: Path where reference genomes are located. 

    - *refGenome: "/path/to/reference/genomes"*

- snpEff config path: Path to snpEff config file that overrides default config. 

    - *snpEffconfig: "snpEff.config"*

- mpileup options: Options to filter bam file before iVar processing.

    - *mpileupParams: "-aa --count-orphans --no-BAQ --max-depth 500000 -Q 0"*

- iVar options: Options to filter low quality variant calls. 
    
    - \-q Minimum quality score threshold to count base (Default: 20)
      
    - \-t Minimum frequency threshold(0 - 1) to call variants (Default: 0.03)
  
    - *ivarParams: "-q 20 -t 0.03"*

- iVar to VCF conversion options:
  
     - \--pass_only: Only output variants that PASS all filters.
      
     - \--allele_freq_thresh: Only output variants where allele frequency greater than this number. 

     - *convertToVcfParams: "--pass_only --allele_freq_thresh 0"*

#### Running the pipeline

cd into the pipeline folder and execute *start.sh* to submit job to cluster. 
