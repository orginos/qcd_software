#!/bin/bash
#
#################
# BUILD Primme
#################
source env.sh

#pushd ${SRCDIR}/primme
#autoreconf -f -i 
#popd

pushd ${BUILDDIR}

if [ -d ./build_primme ]; 
then 
  rm -rf ./build_primme
fi

mkdir  ./build_primme
cd ./build_primme


export PRIMME_LDFLAGS="-framework Accelerate"
export PRIMME_LIBS=" -lprimme -lm -llapack -lblas" 
export TOP="${BUILDDIR}/build_primme"

export PK_CC
export PK_F77
export PK_CFLAGS
export INSTALLDIR

cp -r ${SRCDIR}/primme/* .


#${MAKE} 
#${MAKE} install

make lib CC="${PK_CC}" CFLAGS="${PK_CFLAGS}"

# configure primme:

cat<<EOF > primme-config 
#!/bin/sh

# prime-config
#
# Inspired by qdp++-config from George T. Fleming
#
# Tool for retrieving configuration information about the installed version
# of PRIMME.
#
# This script was copied from the qdp++-config. The latter was
# inspired by many similar scripts available in RedHat Linux,
# including gnome-config, gtk-config and xmms-config.
#
# Be on the lookout for problems with undesirable CXXFLAGS and LDFLAGS
# propagating through this script.

prefix=${INSTALLDIR}/primme
exec_prefix=\${prefix}
exec_prefix_set=no

version="1.2.2"

extra_libs=""

primme_cc=$PK_CC
primme_cflags="-I${INSTALLDIR}/primme/include $PK_CFLAGS"
primme_ldflags="-L${INSTALLDIR}/primme/lib  $PRIMME_LDFLAGS $PK_LDFLAGS"
primme_libs="$PRIMME_LIBS"

primme_ranlib="ranlib"
primme_ar="ar"

usage()
{
 
echo "Usage: primme-config [OPTIONS]
Options:
  [--prefix[=DIR]]
  [--exec-prefix[=DIR]]
  [--version]
  [--cc]
  [--cflags]
  [--ldflags]
  [--libs]
  [--ranlib]
  [--ar]
"
  exit \$1
}

if test \$# -eq 0; then
  usage 1 1>&2
fi

while test \$# -gt 0; do
  case "\$1" in
    -*=*) optarg=\`echo "\$1" | sed 's/[-_a-zA-Z0-9]*=//'\` ;;
    *)    optarg= ;;
  esac

  case \$1 in
    --prefix=*)
      prefix=$optarg
      if test $exec_prefix_set = no ; then
        exec_prefix=$optarg
      fi
      ;;

    --prefix)
      echo_prefix=yes
      ;;

    --exec-prefix=*)
      exec_prefix=$optarg
      exec_prefix_set=yes
      ;;

    --exec-prefix)
      echo_exec_prefix=yes
      ;;

    --version)
      echo \$version
      ;;

    --cc)
      echo \$primme_cc
      ;;

    --cflags)
      echo_cflags=yes
      ;;

    --ldflags)
      echo_ldflags=yes
      ;;

    --libs)
      echo_libs=yes
      ;;

    --ranlib)
       echo \${primme_ranlib}
       ;;
    
    --ar)
       echo \${primme_ar}
       ;;
    *)
      usage 1 1>&2
      ;;

  esac
  shift
done

if test "X\${echo_prefix}X" = "XyesX" ; then
  echo \$prefix
fi

if test "X\${echo_exec_prefix}X" = "XyesX" ; then
  echo \$exec_prefix
fi

if test "X\${echo_cflags}X" = "XyesX" ; then
  output_cflags=
  for i in \$primme_cflags ; do
    case \$i in
      -I/usr/include) ;;
      -g) ;;
#     -O*) ;;
#     -W*) ;;
      *)
        case " \$output_cflags " in
          *\ \$i\ *) ;;                             # already there, skip it
          *) output_cflags="\$output_cflags \$i" # add it to output
        esac
    esac
  done
  echo \$output_cflags
fi

if test "X\${echo_ldflags}X" = "XyesX" ; then
  output_ldflags=
  for i in \$primme_ldflags ; do
    if test "X\${i}X" != "X-I/usr/libX" ; then
      case " \$output_ldflags " in
        *\ \$i\ *) ;;                               # already there, skip it
        *) output_ldflags="\$output_ldflags \$i"     # add it to output
      esac
    fi
  done
  echo \$output_ldflags
fi

# Straight out any possible duplicates, but be careful to
# get "-lfoo -lbar -lbaz" for "-lfoo -lbaz -lbar -lbaz"
# NONONO!!! DON'T DO THIS. SOMETIMES you need a -l twice
if test "X\${echo_libs}X" = "XyesX" ; then
  rev_libs=
  for i in \$primme_libs ; do
    rev_libs="\$i \$rev_libs"
  done
  output_libs=
  for i in \$rev_libs ; do
    case " \$output_libs " in
      *) output_libs="\$i \$output_libs" ;;  # add it to output in reverse order
    esac
  done
  echo \$output_libs
fi

EOF
chmod +x primme-config


#install

if [ -d ${INSTALLDIR}/primme ] ; then  rm -rf ${INSTALLDIR}/primme ; fi
mkdir ${INSTALLDIR}/primme
mkdir ${INSTALLDIR}/primme/bin
mkdir ${INSTALLDIR}/primme/lib
mkdir ${INSTALLDIR}/primme/include
mv *.a  ${INSTALLDIR}/primme/lib
mv primme-config ${INSTALLDIR}/primme/bin
cp PRIMMESRC/COMMONSRC/*.h ${INSTALLDIR}/primme/include

popd
