#!/bin/bash

#$ -l h_rt=48:00:00
#$ -l h_vmem=5G
#$ -l cputype=intel
#$ -cwd -V
#$ -m be

G_INI=$1
G_END=$2

#cd ~/PhD-work/_tools/dapa-climate-change/trunk/PhD/0007-crop-modelling/scripts/cmip5/
#rm ~/workspace/run_${G_INI}_${G_END}.Rout
R CMD BATCH --slave --no-save "--args g_ini=$G_INI g_end=$G_END" 07.glam-cmip5_runs-run_ARC1.R ~/workspace/arc1_runs/run_${G_INI}_${G_END}.Rout
mv ~/workspace/arc1_runs/run_${G_INI}_${G_END}.Rout ~/workspace/arc1_runs/closed/run_${G_INI}_${G_END}.Rout
