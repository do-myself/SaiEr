# SaiEr
This project is based on the detection and defense of DDoS attacks in SDN in the ipv6 environment

File introduction：

example folder ： web system code
Ryu_migration_test ： Ryu controller code
db_network.sql ： database file of web system
hping3Catch.pcap ：Data package file used to generate ipv6 attack package
mininetTest.py ： Mininet basic topology generation file

The usage of hping3Catch.pcap file is：Use the handlerPcapPackets() function in the Ryu_migration_test/RyuMigration/test.py file to process the file to generate an attack package, Then run the test.py file in the host command line to launch the attack package. The attack package path in the test.py file should be changed to the path stored by yourself.
