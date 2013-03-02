[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
exec dmenu_run
