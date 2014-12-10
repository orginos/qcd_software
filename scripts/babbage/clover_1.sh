#PBS -q regular
#PBS -l nodes=2
#PBS -l walltime=00:10:00
#PBS -N my_job
#PBS -e t_clover_2x_2y_2z_2t.out.$PBS_JOBID.err
#PBS -o t_clover_2x_2y_2z_2t.out.$PBS_JOBID.out

cd $PBS_O_WORKDIR
#source ./env.sh

BY=6
BZ=6
PXY=0
PXYZ=0
SY=1
COMPRESS="-compress12"

get_hostfile

function run()
{
LX=$1
LY=$2
LZ=$3
LT=$4
NCORES=$5
MINCT=$6
SZ=$7
COMPRESS=$8
PREC=$9
AFFINITY=${10}
GEOM="-geom 1 1 1 1" 
NTHREADS=`expr \( ${NCORES} \* ${SY} \* ${SZ} \)`
echo LX=${LX} LY=${LY} LZ=${LZ} LT=${LT}
echo Nodes=${NODES}
echo Geometry is ${GEOM} 
echo Using N=${NTHREADS} threads
echo PREC is ${PREC}

mpirun -genv GOMP_CPU_AFFINITY ${AFFINITY} -genv OMP_NUM_THREADS ${NTHREADS} -n 1 -hostfile hostfile.${PBS_JOBID} \
	./time_clov_noqdp -x ${LX} -y ${LY} -z ${LZ} -t ${LT} -by ${BY} -bz ${BZ} 	-pxy ${PXY} -pxyz ${PXYZ} -c ${NCORES} -minct ${MINCT} -sy ${SY} -sz ${SZ} -prec ${PREC} -i 1000 ${COMPRESS12} ${GEOM}
}

#
run 24 6 12 24 1 1 1 "-compress12" f  "0"
sleep 2
run 24 12 12 24 2 1 1 "-compress12" f "0,1"
sleep 2
run 24 24 12 24  4 1 1 "-compress12" f "0,1,2,3"
sleep 2
run 24 24 24 24  8 1 1 "-compress12" f "0,1,2,3,4,5,6,7"
sleep 2
run 24 24 24 48 16 2 1 "-compress12" f "0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"
sleep2

run 24 6 12 24 1 1 2 "-compress12" f  "0,16"
sleep 2
run 24 12 12 24 2 1 2 "-compress12" f "0,16,1,17"
sleep 2
run 24 24 12 24  4 1 2 "-compress12" f "0,16,1,17,2,18,3,19"
sleep 2
run 24 24 24 24  8 1 2 "-compress12" f "0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23"
sleep 2
run 24 24 24 48 16 2 2 "-compress12" f "0,16,1,17,2,18,3,19,4,20,5,21,6,22,7,23,8,24,9,25,10,26,11,27,12,28,13,29,14,30,15,31"




