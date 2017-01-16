#/bin/bash
numjobs=1
filename=/dev/sda 			#For SSD
#bs=(16K 64K 256K 1M) 		#Sequential-related
#rw=(write read rw)
io=libaio
#iodepth=(1 4 16 32 64 128)
fsync=0
direct=1
size=230g #HAVE TO CHECK THIS VALUE BEFORE RUNNING SCRIPT

for sb in 128K 512K 2M 
do
for fs in 0
do
for wr in read #rw write
do
for iod in 1 #4 16 32 64 128
do
	echo ${wr} 
	echo 850Pro_${sb}_${wr} > ssd/850Pro_${sb}_${wr}_fio2.LST
	iostat -mx /dev/sda 1 > ssd/850Pro_${sb}_${wr}_io2.LST &
	fio --name=${wr}_job  --runtime=1800 --group_reporting \
		--size=${size} --bs=${sb} --rw=${wr}\
		--ioengine=${io} --iodepth=${iod} --time_based=0 \
		--numjobs=1 --fsync=${fs} --direct=${direct} --filename=${filename} > ssd/850Pro_${sb}_${wr}_fio2.LST
	killall iostat
	if [ -f /home/som/fio/ssd/850Pro_${sb}_${wr}_io2.LST ]
	then
		cat /home/som/fio/ssd/850Pro_${sb}_${wr}_io2.LST | awk '/sda/ {print $7}' > ssd/850Pro_${sb}_${wr}_write2.LST
		cat /home/som/fio/ssd/850Pro_${sb}_${wr}_io2.LST | awk '/sda/ {print $6}' > ssd/850Pro_${sb}_${wr}_read2.LST
#		rm /home/som/fio/ssd/${sb}_${iod}_${wr}_io.LST 
	fi
done
done
done 
done
