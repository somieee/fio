#Conducting FIO experiments

#echo fio_rand_ssd
sudo ./fio_rand.sh
sleep 1

echo fio_seq_ssd
sudo ./fio_seq.sh
sleep 1

echo fio_seq_hdd
sudo ./fio_seq_hdd.sh
sleep 1

echo fio_rand_hdd
sudo ./fio_rand_hdd2.sh
sleep 1


