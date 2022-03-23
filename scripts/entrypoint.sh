#! /bin/sh

# Display splash screen
cat /scripts/splash.txt

# Fix permissions
echo "----=========Fixing Permissions=========----";
/scripts/fix_permissions.sh

# Install server
echo "----=============Installing=============----";
su -s "/scripts/install.sh" -p steam

# Start server
echo "----==============Starting==============----";
su -s "/scripts/start.sh" -p steam

echo "----==============Finished==============----";
exit 0
