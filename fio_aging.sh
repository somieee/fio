#DASOM - BEFORE FIO, CONDUCT SSD AGING FIRST

fio --size=230g --filename=/dev/sda --name=seq-write --bs=128k --direct=1 --ioengine=libaio --iodepth=1 --rw=write
fio --size=230g --filename=/dev/sda --name=seq-write2 --bs=128k --direct=1 --ioengine=libaio --iodepth=1 --rw=write



fio --size=230g --filename=/dev/sda --name=rnd-write2 --bs=4k --runtime=3600 --direct=1 --ioengine=libaio --iodepth=64 --rw=randwrite
fio --size=230g --filename=/dev/sda --name=rnd-write2 --bs=4k --runtime=3600 --direct=1 --ioengine=libaio --iodepth=64 --rw=randwrite

