

f_du() {
  dir=$1
  du -k $dir/* 2>/dev/null | grep "^[0-9]\{4,\}" | sort -n 
}
f_du ~/Library/Caches
f_du ~/Library/Receipts
f_du /Library/Caches
f_du /Library/Receipts

ls -l /Library/Packages 2>/dev/null

# do we wanna delete the following
# /Library/Printers
# /Library/Modem\ Scripts