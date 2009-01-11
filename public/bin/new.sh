
f_error() {
  echo "  ERROR: $*"
  exit 1
}

if [ -e $1 ] ; then
  f_error "File <$1> already exists"
fi

extension=`echo $1 | cut -d. -f2`

if [ "$extension" == "rb" ] ; then
  shebang="#!/usr/bin/env ruby"
fi

if [ "$shebang" == "" ] ; then
  f_error "Invalid extension: <$extension>"
fi

echo $shebang > $1
chmod 700 $1
vi $1
