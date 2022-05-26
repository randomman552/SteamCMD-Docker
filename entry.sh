#! /bin/sh
# Display splash screen
cat /splash.txt
echo

# Fix permissions
echo "----=========Fixing Permissions=========----";
usermod -u ${PUID} steam
groupmod -g ${PGID} steam
chown steam:steam /server

# Execute scripts in order
echo "----==========Executing scripts=========----";
for s in /scripts/*.sh;
do
    echo "----====$s====----"
    runuser -u steam -g root "$s"
done

echo "----==============Finished==============----";
exit 0
