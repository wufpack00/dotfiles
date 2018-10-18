if command_exists type ; then
  function show_virtual_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
      echo "($(basename $VIRTUAL_ENV))"
    fi
  }
  export -f show_virtual_env >/dev/null 2>&1
  PS1='$(show_virtual_env)'$PS1
fi
