# dumps param value pairs of an xci file in sorted order
# (typically useful to compare 2 ips)
# supports both xml and json form ips

if [ $# != 1 ]
then
    echo "Usage:  $0 <xcifile>"
    exit 1
fi

FILE=$1

if [ ! -f "$FILE" ]
then
    echo "No such file: " $FILE
    exit 1
fi

( file -L $FILE | grep -q XML && xcicat_xml.py $FILE || xcicat_json.py $FILE ) |
sort

