function getVersion() 
{
   git log | head -1 | awk '{ print $2}'
}

for x in qmp qdpxx qphix chroma
do
   cd $x 
   foo=`getVersion`
   echo $x "commmit ID: " $foo
   cd ..    
done
