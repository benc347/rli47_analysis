#!/bin/bash 

#SBATCH --time=48:00:00					##(day-hour:minute:second) sets the max time for the job
#SBATCH --cpus-per-task=4	 			##request number of cpus
#SBATCH --mem=16G						##max ram for the job

#SBATCH --nodes=1						##request number of nodes (always keep at 1)
#SBATCH --mail-user=bienvenido.tibbs-cortes@usda.gov		##email address to mail specified updates to
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END					##these say under what conditions do you want email updates
#SBATCH --mail-type=FAIL
#SBATCH --output="00_rsem_index_slurmlog_%j"		##names what slurm logfile will be saved to 


# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
## slurm break

module load rsem
module load bowtie2

# Uses an RSEM index to quantify reads
# GTF is the .gtf file for the strain
# The .fasta file is the genome fasta for the strain

outname=$1
GTF=$2
fasta=$3

mkdir ${outname%/*}

rsem-prepare-reference --gtf $GTF \
						--bowtie2 \
						$fasta \
						$outname
