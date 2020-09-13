#!/bin/bash
# ssh onto millennium, navigate to generator directory, convert waveform to .vcd and scp it back

#set -x

SERVER="a8.millennium.berkeley.edu"
USR="sondhi.tushar"
OUT="out.txt"
LOCAL_DIR=~/CArchResearch/scripts
WAVE_OUT="$1"
ssh $USR@$SERVER 'cd /scratch/sondhi.tushar/firesim;source env.sh;cd sim/generated-src/f1/AXI4Strider-DefaultConfig-DefaultF1Config;vpd2vcd waves.vpd waveform.vcd' w > $OUT

scp sondhi.tushar@a8.millennium.berkeley.edu:/scratch/sondhi.tushar/firesim/sim/generated-src/f1/AXI4Strider-DefaultConfig-DefaultF1Config/waveform.vcd $LOCAL_DIR/

mv waveform.vcd ../waveform_receptacle/AXI4Stride/$WAVE_OUT

cd ../waveform_receptacle/
git add AXI4Stride/$WAVE_OUT
git commit -m "upload $WAVE_OUT"
git push
