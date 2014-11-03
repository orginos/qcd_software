#! /bin/bash

if [ ! -d ./build ];
then
 echo Build Directory not present. Creating
 mkdir build
fi

if [ ! -d ./install ];
then 
 echo Install Directory not present Creating 
 mkdir install
fi
