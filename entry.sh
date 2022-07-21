#! /bin/sh
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
