#!/bin/bash

set -e

MOUNTPOINT=mountpoint
BACK_FILE=back.file
DEVICE=/dev/loop0

mkdir mountpoint

# create loop device with losetup
function create_with_losetup {
    losetup $DEVICE $BACK_FILE
    mkfs -t ext4 $DEVICE
    mount $DEVICE $MOUNTPOINT
}

# create loop device with shorthand commands
function create_with_mount {
    mkfs.ext4 $BACK_FILE
    mount -o loop $BACK_FILE $MOUNTPOINT
}

# create empty 1M file
dd if=/dev/zero of=$BACK_FILE bs=512 count=20000

# should work with both
create_with_losetup
#create_with_mount

# create 100 files in the new mount
for i in {1..100}; do touch "$MOUNTPOINT/file$i"; done

# cleanup function
function finish {
    echo "Cleaning up..."
    losetup -d $DEVICE # will fail silently if mount -o loop was used
    umount $MOUNTPOINT
    rmdir $MOUNTPOINT
    rm back.file
    echo "Done."
}

trap finish EXIT
