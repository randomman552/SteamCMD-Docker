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
su steam -s "/scripts/install.sh"

# Start server
echo "----==============Starting==============----";
su steam -s "/scripts/start.sh"

echo "----==============Finished==============----";
exit 0
