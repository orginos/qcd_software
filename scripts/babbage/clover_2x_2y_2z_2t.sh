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
NCORES=16
MINCT=2
SY=1
SZ=2
COMPRESS="-compress12"

get_hostfile

function run()
{
LX=$1
LY=$2
LZ=$3
LT=$4
NODES=$5
GEOMETRY=$6
COMPRESS=$7
PREC=$8
GEOM="-geom ${GEOMETRY}"
NTHREADS=`expr \( ${NCORES} \* ${SY} \* ${SZ} \)`
echo LX=${LX} LY=${LY} LZ=${LZ} LT=${LT}
echo Nodes=${NODES}
echo Geometry is ${GEOM} 
echo Using N=${NTHREADS} threads
echo PREC is ${PREC}

mpirun -genv KMP_AFFINITY compact -genv OMP_NUM_THREADS ${NTHREADS} -n ${NODES} -hostfile hostfile.${PBS_JOBID} \
	./time_clov_noqdp -x ${LX} -y ${LY} -z ${LZ} -t ${LT} -by ${BY} -bz ${BZ} 	-pxy ${PXY} -pxyz ${PXYZ} -c ${NCORES} -minct ${MINCT} -sy ${SY} -sz ${SZ} -prec ${PREC} -i 1000 ${COMPRESS12} ${GEOM}
}



run 24 24 24 48  1 "1 1 1 1" "-compress12" f
sleep 3
run 24 24 24 96  2 "1 1 1 2" "-compress12" f
