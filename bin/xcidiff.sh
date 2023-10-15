# Scipt to compare configurations of two xci files
if [ $# != 2 ]
then
    echo "Usage: $0 <xcifile1> <xcifile2>"
    exit 1
fi

sdiff -s  <(xcicat.sh $1) <(xcicat.sh $2)
