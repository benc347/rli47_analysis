#!/bin/bash 

#SBATCH --time=48:00:00					##(day-hour:minute:second) sets the max time for the job
#SBATCH --cpus-per-task=40	 			##request number of cpus
#SBATCH --mem=64G						##max ram for the job

#SBATCH --nodes=1						##request number of nodes (always keep at 1)
#SBATCH --mail-user=YOUR_EMAIL_HERE			##email address to mail specified updates to
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END					##these say under what conditions do you want email updates
#SBATCH --mail-type=FAIL
#SBATCH --output="00_rsem_quantify_slurmlog_%j"		##names what slurm logfile will be saved to 

#this script runs RSEM map and quantify reads against an annotated genome
	#for single end reads ONLY
 	#script is designed to be invoked by 2_RSEM_controller.sh
  		#can be run on its own though
 
#load modules
module load rsem
module load bowtie2
module load samtools

#accept user input
	#rep - fastq file to map against the reference
 	#ref - RSEM index created using 1_RSEM_index.sh
  	#outdir - output directory created by 2_RSEM_controller.sh
   	#fragmean - mean read length calculated by 2_RSEM_controller.sh
    	#fragsd - standard deviation of read length calculated by 2_RSEM_controller.sh
     	#strand - strandedness of the library prep. depending on the prep, reads may map to either the forward or opposite strand in the genome
rep=$1
ref=$2
outdir=$3
fragmean=$4
fragsd=$5
strand=$6

# Have to use bowtie2 to align
# --no-bam-output means no bam file is output, but a bam file will still be generated during alignment
# --estimate-rspd assesses positional biases (RSEM)
# --append-names keeps gene and transcript names associated with data, necessary for DeSeq2

rsem-calculate-expression -p 40 \
						--bowtie2 \
						--no-bam-output \
						--strandedness $strand \
						--estimate-rspd \
						--append-names \
						--fragment-length-mean $fragmean \
						--fragment-length-sd $fragsd \
						$rep $ref $outdir
