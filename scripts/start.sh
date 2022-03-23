#! /bin/sh
# Script starts the server if the START_CMD is set
if [ -n "$START_CMD" ];
then
    $START_CMD;
    exit 0;
fi
echo "START_CMD is unset, skipping..."
exit 1;
