#
# Make a directory and change to it
#
function mkcd() {
  if [ $# -ne 1 ]; then
         echo "Usage: mkcd <dir>"
         return 1
  else
         mkdir -p "$@" && cd "$_"
  fi
}
