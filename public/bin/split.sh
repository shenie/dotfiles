
fs=$1
file=$2

awk '{print "========="; c=split($0, s, fs); for(n=1; n<=c; ++n) print s[n] }' fs=$fs $file

