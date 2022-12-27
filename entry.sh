#! /bin/sh
# Trap any SIGINT and SIGTERM Kill all child processes when recieved
trap "trap '' TERM; kill 0; wait" INT TERM

# Display splash screen
cat /splash.txt
echo

# Fix permissions
echo "----=========Fixing Permissions=========----";
sh /perms.sh

# Execute scripts in order
echo "----==========Executing scripts=========----";
for s in /scripts/*.sh;
do
    echo "----====$s====----"
    runuser -u steam -g steam "$s"
done

echo "----==============Finished==============----";
exit 0
