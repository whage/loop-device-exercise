#!/bin/bash

MOUNTPOINT=mountpoint

umount $MOUNTPOINT
losetup -d /dev/loop0
rmdir $MOUNTPOINT
rm back.file
