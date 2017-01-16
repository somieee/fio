#/bin/bash
#directory=/home/som/pgdata2/SSD/
numjobs=1
filename=/dev/sdd #For HDD #HAVE TO CHECK THIS VALUE BEFORE RUNNING SCRIPT
#filename=/dev/sda #For SSD
#bs=(4K) 					#random-related
#bs=(16K 64K 256K 1M) #Sequential-related
#rw=(write read rw)
#rw=(randwrite randrw randread)
io=libaio
#iodepth=(1 4 16 32 64 128)
#iodepth=(1 4 16 32 64 128)	 #sequential-related
#fsync=(0)
direct=1
size=900g #HAVE TO CHECK THIS VALUE BEFORE RUNNING SCRIPT

for sb in 4K
do
for fs in 0
do
for wr in randwrite randread #randrw
do
for iod in 32 #64 128
do
	echo ${wr} 
	echo ${wr} > hdd/${sb}_${iod}_${wr}_fio.LST
	iostat -mx /dev/sdd 1 > hdd/${sb}_${iod}_${wr}_io.LST &
	fio --name=${wr}_job  --runtime=3600 --group_reporting \
		--size=${size} --bs=${sb} --rw=${wr}\
		--ioengine=${io} --iodepth=${iod} --time_based=1\
		--numjobs=1 --fsync=${fs} --direct=${direct} --filename=${filename} > hdd/${sb}_${iod}_${wr}_fio.LST
	killall iostat
	if [ -f /home/som/fio/hdd/${sb}_${iod}_${wr}_io.LST ]
	then
		cat /home/som/fio/hdd/${sb}_${iod}_${wr}_io.LST | awk '/sdd/ {print $7}' > hdd/${sb}_${iod}_${wr}_write.LST
		cat /home/som/fio/hdd/${sb}_${iod}_${wr}_io.LST | awk '/sdd/ {print $6}' > hdd/${sb}_${iod}_${wr}_read.LST
#		rm /home/som/fio/hdd/${sb}_${iod}_${wr}_io.LST 
	fi
done
done
done 
done
