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
su -s "/scripts/install.sh" -p steam

# Start server
echo "----==============Starting==============----";
su -s "/scripts/start.sh" -p steam

echo "----==============Finished==============----";
exit 0
