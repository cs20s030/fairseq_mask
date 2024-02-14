#! /bin/bash
#SBATCH --nodes=1
#SBATCH --exclude=scn42-10g
#SBATCH --partition=nltmp
#SBATCH --cpus-per-task=64
#SBATCH --gres=gpu:A100-SXM4:4
#SBATCH --time=7-0:00:00
#SBATCH --error=job.%J.err
##SBATCH --output=job.%J.out
#cd $SLURM_SUBMIT_DIR
#cd /nlsasfs/home/sysadmin/nazgul/gpu-burn-master
echo "Starting at `date`"
echo "Running on hosts: $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running $SLURM_NTASKS tasks."
echo "Job id is $SLURM_JOBID"
echo "Job submission directory is : $SLURM_SUBMIT_DIR"
#srun ./gpu_burn -tc -d 3600 #
#srun /bin/hostname
source /nlsasfs/home/nltm-pilot/arjung/ash_exp_acl/env.sh
source /nlsasfs/home/nltm-pilot/arjung/ash_exp_acl/expt_fq_mask_ash/bin/activate
srun python fairseq_cli/hydra_train.py -m --config-dir examples/data2vec/config/v2 --config-name base_audio_only_task task.data=/nlsasfs/home/nltm-pilot/vasistal/wav2vec_960_100_data/360h_manifests
