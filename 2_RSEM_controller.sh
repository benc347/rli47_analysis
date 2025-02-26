#!/bin/bash 

#SBATCH --time=48:00:00					##(day-hour:minute:second) sets the max time for the job
#SBATCH --cpus-per-task=8	 			##request number of cpus
#SBATCH --mem=16G						##max ram for the job

#SBATCH --nodes=1						##request number of nodes (always keep at 1)
#SBATCH --mail-user=YOUR_EMAIL_HERE	##email address to mail specified updates to
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END					##these say under what conditions do you want email updates
#SBATCH --mail-type=FAIL
#SBATCH --output="00_rsem_master_slurmlog_%j"		##names what slurm logfile will be saved to 

#load modules
module load rsem
module load bowtie2

#accept user input
#ref - the RSEM index created by 1_RSEM_index.sh
#outdir - an output directory to export results to
ref=$1
outdir=${2%/}
mkdir $outdir

#runs RSEM on all single-end fastq files
#first calculates read length mean (fragmean) and sd (fragsd) for input

for rep in *clean.fastq; do
	fragmean=$(awk 'BEGIN { t=0.0;sq=0.0; n=0;} ;NR%4==2 {n++;L=length($0);t+=L;sq+=L*L;}END{print m=t/n;}' $rep)
	fragsd=$(awk 'BEGIN { t=0.0;sq=0.0; n=0;} ;NR%4==2 {n++;L=length($0);t+=L;sq+=L*L;}END{m=t/n; print sqrt(sq/n-m*m);}' $rep)
	#echo $fragmean $fragsd
	
	sbatch 3_quantify_RSEM.sh $rep $ref ${outdir}/${rep%*_clean.fastq} $fragmean $fragsd
	
done
