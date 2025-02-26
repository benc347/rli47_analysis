#!/bin/bash 

#SBATCH --time=48:00:00					##(day-hour:minute:second) sets the max time for the job
#SBATCH --cpus-per-task=4	 			##request number of cpus
#SBATCH --mem=16G						##max ram for the job

#SBATCH --nodes=1						##request number of nodes (always keep at 1)
#SBATCH --mail-user=YOUR_EMAIL_HERE			##email address to mail specified updates to
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END					##these say under what conditions do you want email updates
#SBATCH --mail-type=FAIL
#SBATCH --output="00_rsem_index_slurmlog_%j"		##names what slurm logfile will be saved to 

#load modules
module load rsem
module load bowtie2

#accept user input
#outname - name of output directory to store RSEM index 
#need to prepare an RSEM index from the genome of interest to quantify reads
	# GTF - the .gtf file for the genome
	# fasta - fasta file of the genome of interest

outname=$1
GTF=$2
fasta=$3

mkdir ${outname%/*}

rsem-prepare-reference --gtf $GTF \
						--bowtie2 \
						$fasta \
						$outname
