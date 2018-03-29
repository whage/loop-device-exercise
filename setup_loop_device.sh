dd if=/dev/zero of=./back.file bs=512 count=20000
losetup /dev/loop0 back.file
mkfs -t ext4 /dev/loop0
mkdir mountpoint
mount /dev/loop0 mountpoint
cd mountpoint && for i in {1..100}; do touch 'file$i'; done
