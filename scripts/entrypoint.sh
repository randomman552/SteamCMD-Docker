#! /bin/sh

cat << "EOF"
============================================
|  ___ _                  ___ __  __ ___   |
| / __| |_ ___ __ _ _ __ / __|  \/  |   \  |
| \__ \  _/ -_) _` | '  \ (__| |\/| | |) | |
| |___/\__\___\__,_|_|_|_\___|_|  |_|___/  |
============================================
EOF

# Fix permissions
echo "----=========Fixing Permissions=========----";
/scripts/fix_permissions.sh

# Install server
echo "----=============Installing=============----";
runuser -l steam -c "/scripts/install.sh" -w APP_ID

# Start server
echo "----==============Starting==============----";
runuser -l steam -c "/scripts/start.sh" -w START_CMD
echo "----==============Finished==============----";

exit 0
