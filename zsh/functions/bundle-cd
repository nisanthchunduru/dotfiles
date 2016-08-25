bundle-cd () {
  gem_name=$1
  bundle_show_output=`bundle show $gem_name`

  if [ -d "$bundle_show_output" ]; then
  	gem_path=$bundle_show_output
  	cd $gem_path
  else
  	error_message=$bundle_show_output
  	echo "\e[0;31;49m$error_message\e[0m"
  fi
}
