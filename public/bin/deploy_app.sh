
environment=$1
shift
source=$1
shift

if [ "$environment" == "" ] ; then
  echo "Error: need to specify environment"
  exit 1
fi

if [ ! -r ${HOME}/bin/${environment}.properties ] ; then
  echo "Error: Can't read $environment properties file"
  exit 1
fi

if [ "$source" == "" ] ; then
  echo "Error: need to supply source directory"
  exit 1
fi

if [ ! -d ${source} ] ; then
  echo "Error: $source is not a directory"
  exit 1
fi

. ${environment}.properties

rsync --rsh="ssh -l ${user}" --cvs-exclude --times --progress --checksum --stats --recursive $* $source ${server}:${app}/$source

