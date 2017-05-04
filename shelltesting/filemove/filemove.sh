#Aboslute path of executed shell script
DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

#Echo non-hidden files in dir1
echo "--Non-hidden files in dir1"
for FILE in ${DIR}/dir1/*
do
    echo $(basename $FILE)
done
echo

#Echo hidden files in dir1
echo "--Hidden Files in dir1"
for FILE in ${DIR}/dir1/.*
do
    echo $(basename $FILE)
done
echo

#Echo all files in dir1
echo "--All Files in dir1"
for FILE in ${DIR}/dir1/.* ${DIR}/dir1/* #can be sub with {.,}* or {.*,*}
do
    echo $(basename $FILE)
done
echo

#Copy all files in dir1 into dir2
echo "--All Files in dir1"
for FILE in ${DIR}/dir1/.* ${DIR}/dir1/*
do
    cp $FILE ${DIR}/dir2/    
done
echo
