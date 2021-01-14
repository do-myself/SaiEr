# SaiEr
该项目是基于ipv6环境的SDN中DDoS攻击的检测和防御

文件介绍：

example文件夹：Web系统代码

Ryu_migration_test：Ryu控制器代码

db_network.sql：Web系统的数据库文件

hping3Catch.pcap：用于生成ipv6攻击包的数据包文件

mininetTest.py：Mininet基本拓扑生成文件

hping3Catch.pcap文件的用法是：使用Ryu_migration_test/RyuMigration/test.py文件中的handlerPcapPackets()函数来处理该文件以生成攻击包，然后在主机命令行中运行test.py文件以发送攻击包。 其中test.py文件中的攻击包路径应更改为自己存储的路径。


This project is based on the detection and defense of DDoS attacks in SDN in the ipv6 environment

File introduction：

example folder ： web system code

Ryu_migration_test ： Ryu controller code

db_network.sql ： database file of web system

hping3Catch.pcap ：Data package file used to generate ipv6 attack package

mininetTest.py ： Mininet basic topology generation file

The usage of hping3Catch.pcap file is：Use the handlerPcapPackets() function in the Ryu_migration_test/RyuMigration/test.py file to process the file to generate an attack package, Then run the test.py file in the host command line to launch the attack package. The attack package path in the test.py file should be changed to the path stored by yourself.
