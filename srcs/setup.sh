HOST="127.0.0.1 ychalant.42.fr"
HOST_FILE=/etc/hosts

if ! grep -Fxq "$HOST" $HOST_FILE; then
	echo "$HOST" >> $HOST_FILE
fi