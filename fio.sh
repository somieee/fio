#/bin/bash
#directory=/home/som/pgdata2/SSD/
numjobs=1
#filename=/dev/sdd #For HDD #HAVE TO CHECK THIS VALUE BEFORE RUNNING SCRIPT
filename=/home/som/ddtest  
bs=(16K 64K 256K 1M) 			#Sequential-related
rw=(write read rw)
io=libaio
iodepth=(1 4 16 32 64 128)
fsync=(0)
direct=1
size=5g #HAVE TO CHECK THIS VALUE BEFORE RUNNING SCRIPT

for sb in ${bs[@]}
do
for fs in ${fsync[@]}
do
for wr in ${rw[@]}
do
for iod in ${iodepth[@]}
do
	echo ${wr} 
	echo ${wr} > fio/ssd/${sb}_${iod}_${wr}_fio.LST
	iostat -mx /dev/sdd 1 > fio/ssd/${sb}_${iod}_${wr}_io.LST &
	fio --name=${wr}_job  --runtime=3600 --group_reporting \
		--size=${size} --bs=${sb} --rw=${wr}\
		--ioengine=${io} --iodepth=${iod}\
		--numjobs=1 --fsync=${fs} --direct=${direct} --filename=${filename} > fio/ssd/${sb}_${iod}_${wr}_fio.LST
	killall iostat
	if [ -f /home/som/fio/ssd/${sb}_${iod}_${wr}_io.LST ]
	then
		cat /home/som/fio/ssd/${sb}_${iod}_${wr}_io.LST | awk '/sde/ {print $7}' > ${sb}_${iod}_${wr}_write.LST
		cat /home/som/fio/ssd/${sb}_${iod}_${wr}_io.LST | awk '/sde/ {print $6}' > ${sb}_${iod}_${wr}_read.LST
		rm /home/som/fio/ssd/${sb}_${iod}_${wr}_io.LST 
	fi
done
done
done 
done
