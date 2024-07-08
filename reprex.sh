#!/bin/bash
#SBATCH --partition=med2
#SBATCH --mem=2000
#SBATCH --time=00:04:00
#SBATCH --cpus-per-task=1
#SBATCH -D /home/kslauck/projects/reprex
#SBATCH --output=test_job.out
#SBATCH --error=test_job.err

echo "Partition: $SLURM_JOB_PARTITION"

conda run -n reprex snakemake --unlock --snakefile reprex

conda run -n reprex snakemake --profile .

# Print out values of the current jobs SLURM environment variables
env | grep SLURM

# Print out final statistics about resource use before job exits
scontrol show job ${SLURM_JOB_ID}

sstat --format 'JobID,MaxRSS,AveCPU' -P ${SLURM_JOB_ID}.batch
