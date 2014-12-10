#PBS -q debug
#PBS -A m2176
#PBS -l mppwidth=384
#PBS -l walltime=00:20:00
#PBS -N t_clover_2x_2y_2z_2t.out
#PBS -j oe
#PBS -V

cd $PBS_O_WORKDIR
source ./env.sh

BY=6
BZ=6
PXY=0
PXYZ=0
NCORES=24
MINCT=2
SY=1
SZ=2
COMPRESS="-compress12"

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
export KMP_AFFINITY=compact
APRUN="aprun -j 2 -n ${NODES} -N 1 -d 48 -cc none"
GEOM="-geom ${GEOMETRY}"
NTHREADS=48
echo LX=${LX} LY=${LY} LZ=${LZ} LT=${LT}
echo Nodes=${NODES}
echo Geometry is ${GEOM} 
echo Using N=${NTHREADS} threads
echo APRUN is ${APRUN}
echo PREC is ${PREC}
export OMP_NUM_THREADS=${NTHREADS}

${APRUN} ./time_clov_noqdp \
	-x ${LX} -y ${LY} -z ${LZ} -t ${LT}  \
	-by ${BY} -bz ${BZ} \
	-pxy ${PXY} -pxyz ${PXYZ} \
	-c ${NCORES} -minct ${MINCT} \
	-sy ${SY} -sz ${SZ} -prec ${PREC} -i 1000 \
	${COMPRESS12} ${GEOM}
}


export MPICH_RANK_REORDER_METHOD=0

run 48 48 48 96 16 "2 2 2 2" f
sleep 3
run 24 48 48 96  8 "1 2 2 2" f
sleep 3 
run 24 24 48 96  4 "1 1 2 2" f
sleep 3
run 24 24 24 96  2 "1 1 1 2" f
sleep 3
run 24 24 24 48  1 "1 1 1 1" f


run 48 48 48 96 16 "2 2 2 2" f
sleep 3
run 24 48 48 96  8 "1 2 2 2" f
sleep 3
run 24 24 48 96  4 "1 1 2 2" f
sleep 3
run 24 24 24 96  2 "1 1 1 2" f
sleep 3
run 24 24 24 48  1 "1 1 1 1" f

