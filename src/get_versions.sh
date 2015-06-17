function getVersion() 
{
   git log | head -1 | awk '{ print $2}'
}

for x in qdp qmp qdpxx qphix chroma hadron tensor harom qla qio qopqdp
do
   cd $x 
   foo=`getVersion`
   echo $x "commmit ID: " $foo
   cd ..    
done
