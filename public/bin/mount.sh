
name=$1

/usr/sbin/diskutil list | grep $name | while read a 
do
  drive=`echo $a | cut -d' ' -f6 `
  /usr/sbin/diskutil mount $drive
done

