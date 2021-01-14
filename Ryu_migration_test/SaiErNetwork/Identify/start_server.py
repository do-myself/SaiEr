import binascii
import socket,time
from SaiErNetwork.Identify.HandlePackets import createPackets as cp
from SaiErNetwork.Identify.start import StartIdentify as si
from SaiErNetwork.Identify.start import LoadModel
from SaiErNetwork.Identify.Config import *
import threading
import sys,copy


class RecvMessage():
    def __init__(self):
        self.model = LoadModel()
        self.resultlist = []

    # def open(self):
    #     print("already start...")
    #     sock2s = sock2(self.resultlist)
    #     sock2s.start()

    def recvMessage(self,handlist):
        sock = sock1(self.model,self.resultlist,handlist)
        sock.start()


'''
    k {
             0   1     2   3     4     5     6-9     10-15       16
            sip sport dip dport proto time length*4 tcpflags*6 label
            tcpflags{
                FIN Flag ,SYN Flag , RST Flag , PSH Flag , ACK Flag , URG Flag 
            }
    }
    
    tcp{
    <TCP  sport=https dport=47268 seq=1671449309 ack=3941245926 dataofs=5 
    reserved=0 flags=A window=64240 chksum=0xa19a urgptr=0 |
    }
        
    def SetTeZheng(self,list,flaglist,length):
        self.TeZheng.append(list[0])
        self.TeZheng.append(list[3])
        self.TeZheng.append(list[1])
        self.TeZheng.append(list[4])
        self.TeZheng.append(list[2])
        self.TeZheng.append(0)
        self.TeZheng.append(length)
        self.TeZheng.append(length)
        self.TeZheng.append(length)
        self.TeZheng.append(length)
        self.TeZheng.append(flaglist["F"])
        self.TeZheng.append(flaglist["S"])
        self.TeZheng.append(flaglist["R"])
        self.TeZheng.append(flaglist["P"])
        self.TeZheng.append(flaglist["A"])
        self.TeZheng.append(flaglist["U"])
        
    def HandlerSinglePackage(self, ips,tcps=None,udps=None):
        # print("................")
        flaglist = {}
        list = []
        list.append(self.IP_to_Integer(self.IP_to_array(ips.src)))
        list.append(self.IP_to_Integer(self.IP_to_array(ips.dst)))
        list.append(ips.proto)
        if tcps:
            list.append(tcps.src_port)
            list.append(tcps.dst_port)
            flaglist = self.HandlerTcpFlags(tcps.bits)
        if udps:
            list.append(udps.src_port)
            list.append(udps.dst_port)
            flaglist = self.HandlerTcpFlags()

        return list, flaglist
        
    def listostr(self,list):
        k = ''
        for i in range(len(list)):
            if i== (len(list)-1):
                k+=str(list[i])
            else:
                k+=str(list[i])+','
        return k
'''


'''
    change:
          File "/root/PycharmProjects/untitled/venv/lib/python3.5/site-packages/keras/backend/tensorflow_backend.py", line 482, in is_tensor
'''

class sock1(threading.Thread):

    def __init__(self,model,resultlist,handlelist):
        super(sock1, self).__init__()
        self.model = model
        self.host = "localhost"
        self.port = 12346
        self.handlelist = handlelist
        self.resultlist = resultlist
        self.src_dpid_port = {}
        # self.sock = socket.socket()
        # self.sock.bind((self.host, self.port))
        # self.sock.listen(1)

    def run(self):
        # self.conn, self.address = self.sock.accept()
        with open("/home/mao/Mao/Documents/check.txt", 'a') as f:
            f.truncate(0)
        with open("/home/mao/Mao/Documents/check1.txt", 'a') as f_:
            f_.truncate(0)
        while 1:
            # try:
            if len(self.handlelist)>0:
                lists = copy.deepcopy(self.handlelist)
                for str in lists:
                    strs = str.split("#####")
                    if len(strs)>0:
                        self.ResultWritetocsvfile(strs[1])
                        # print(str)
                        # start to identify
                        result = self.handle()

                        if result == 1:
                            str = str + "-------->> 1"
                            # self.resultlist.append(str)
                            # 1,2,26:fe:86:c5:e5:7c,1a:6a:c1:0c:5a:d8,2001::5f5:2c1f,2001::a00:8
                            re = strs[0].split(",")
                            if (re[2], re[3], re[4], re[5]) not in self.src_dpid_port:
                                with open("/home/mao/Mao/Documents/check.txt", 'a') as f1:
                                    f1.write(str)
                                    f1.write("\n")
                                with open("/home/mao/Mao/Documents/check1.txt", 'a') as f2:
                                    f2.write(str)
                                    f2.write("\n")
                                self.src_dpid_port[(re[2], re[3], re[4], re[5])] = (re[0], re[1])


                for i in lists:
                    self.handlelist.remove(i)
            time.sleep(1)

    def ResultWritetocsvfile(self, TeZheng):
        with open(rootdir+'test23.csv', 'w') as file:
            file.write(TeZheng)

    def handle(self):
        return cp(model=self.model).result

class sock2(threading.Thread):

    def __init__(self,resultlist,conn = None):
        super(sock2, self).__init__()
        self.host = "localhost"
        self.port = 12350
        self.resultlist = resultlist
        self.sock = socket.socket()
        self.sock.bind((self.host, self.port))
        self.sock.listen(1)

    def run(self):
        self.conn, self.address = self.sock.accept()
        while 1:
            try:
                if self.conn != None:
                    if len(self.resultlist)>0:
                        lists = copy.deepcopy(self.resultlist)
                        for i in lists:
                            # i = '1,00:00:00:00:00:11,00:00:00:00:00:13,9.56.39.214,10.0.0.3#####153565193,5325,167772170,53,6,0,40,40,40,40,0,0,0,0,0,0-------->> 1'
                            # self.conn.send(i.encode())
                            # sys.stdout.flush()
                            '''
                                this write check rsult ,put in /home/mao/Mao/Documents/check.txt
                            '''
                            with open("/home/mao/Mao/Documents/check.txt",'a') as f:
                                f.write(i)
                                f.write("\n")

                            time.sleep(0.001)
                        for i in lists:
                            self.resultlist.remove(i)
                    else:
                        time.sleep(1)
                else:
                    time.sleep(1)
            except:
                print("write error....")
                time.sleep(1)
# 1,00:00:00:00:00:11,00:00:00:00:00:13,9.230.90.210,10.0.0.3#####156952073,6196,167772170,53,6,0,40,40,40,40,0,0,0,0,0,0-------->> 1


    # sock = sock2()
    # sock.start()
