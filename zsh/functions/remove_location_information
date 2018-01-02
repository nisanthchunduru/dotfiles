# @example
#   remove_location_information ~/Desktop/Shared\ Photos
#
# @example
#   remove_location_information ~/Desktop/IMG_0066.jpg
remove_location_information () {
  if [ -d $1 ]; then
    for file_path in "$1"/*
    do
      mogrify -strip "$file_path"
    done
  else
    file_name=$1
    file_path=`realpath $file_name`
    mogrify -strip $file_path
  fi
}
