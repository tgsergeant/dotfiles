#Set cursor
xsetroot -cursor_name left_ptr
udiskie & #Automount things

systemd --user &

mpdscribble &

exec xmonad
