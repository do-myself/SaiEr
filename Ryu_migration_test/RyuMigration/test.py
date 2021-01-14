from ryu.lib.packet import ipv6, tcp
from ryu.lib.packet import packet, ethernet,ether_types
from scapy.all import *
from ryu.lib.packet import *
from scapy.layers.inet6 import *

class testThread(threading.Thread):
    def __init__(self,interface,basepath="/home/mao/Mao/Documents/SaiErNetworkPcap/srcpcap/",
                 targetpath = "/home/mao/Mao/Documents/SaiErNetworkPcap/targetpcap/",targetIP = None):
        super(testThread, self,).__init__()
        self.targetpath = targetpath
        self.basepath = basepath
        self.targetIP = targetIP
        self.splitlength = 100
        self.interface = interface
        self.handlerRecp()

    '''
        handle pcap packets
    '''
    def handlerRecp(self):
        base = os.listdir(self.basepath)
        j = 0
        for i in base:
            print("start to handle packets")
            packets = rdpcap(self.basepath+i)

            self.createPacket(packets,j,path=self.targetpath,targetIP=self.targetIP)
            print("handle this part")
            j+=1
            # for the system not too slow
            time.sleep(0.01)

    '''
        create new packet based on packet you give for scapy
    '''
    def createPacket(self, packets,index,path,targetIP = None):
        lists = []
        # i = 0

        for pack in packets:
            if pack.haslayer("TCP"):
                '''
                  [BitField("version", 6, 4),
                   BitField("tc", 0, 8),  # TODO: IPv6, ByteField ?
                   BitField("fl", 0, 20),
                   ShortField("plen", None),
                   ByteEnumField("nh", 59, ipv6nh),
                   ByteField("hlim", 64),
                   SourceIP6Field("src", "dst"),  # dst is for src @ selection
                   DestIP6Field("dst", "::1")]

                   <Ether  dst=33:33:00:00:00:02 src=4a:e3:b9:6a:dd:f3 type=0x86dd |
                   <IPv6  version=6 tc=0 fl=0 plen=16 nh=ICMPv6 hlim=255 src=fe80::48e3:b9ff:fe6a:ddf3 dst=ff02::2 |
                   <ICMPv6ND_RS  type=Router Solicitation code=0 cksum=0xbaaa res=0 |<ICMPv6NDOptSrcLLAddr  type=1 len=1 lladdr=4a:e3:b9:6a:dd:f3 |>>>>
                '''
                ethers = Ether(src=pack['Ether'].src, dst=pack['Ether'].dst, type=0x86dd)
                headlen = int(pack['IP'].ihl) * 4
                if targetIP == None:
                    dst = self.Ipv4ToIpv6(pack['IP'].dst)
                else:
                    dst = targetIP

                ipv6 = IPv6(src=self.Ipv4ToIpv6(pack['IP'].src), dst=dst,
                            version=6, nh=ipv6nh[6], hlim=pack['IP'].ttl, plen=int(pack['IP'].len) - headlen)
                tcp = pack['TCP']
                pkt = ethers / ipv6 / tcp
                lists.append(pkt)

                # if len(lists) >= 10000:
                #     wrpcap(path+"packet%s.pcap"%i,lists)
                #     lists.clear()
                #     i+=1
                # else:
                #     wrpcap(path + "packet%s.pcap" % i, lists)
                #     lists.clear()
                #     i += 1

        sendpath = path + "packet%s.pcap" % index
        wrpcap(sendpath, lists)
        lists.clear()
        SendPackets(self.interface,path=sendpath).sendForSpecialPath()


    '''
        create new packet based on packet you give for ryu
    '''
    def createPacketForRyu(self,packets):
        lists = []
        for pack in packets:
            if pack.haslayer("TCP"):
                pkt = packet.Packet()
                eth = ethernet.ethernet(src=pack['Ether'].src, dst=pack['Ether'].dst,
                                        ethertype=ether_types.ETH_TYPE_IPV6)
                pkt.add_protocol(eth)
                headlen = int(pack['IP'].ihl) * 4
                ipv6s = ipv6.ipv6(src=self.Ipv4ToIpv6(pack['IP'].src), dst=self.Ipv4ToIpv6(pack['IP'].dst),
                                  nxt=ipv6.inet.IPPROTO_TCP,
                                  hop_limit=pack['IP'].ttl, payload_length=pack['IP'].len - headlen)
                pkt.add_protocol(ipv6s)
                tcps = tcp.tcp(src_port=pack['TCP'].sport, dst_port=pack['TCP'].dport, seq=pack['TCP'].seq,
                               ack=pack['TCP'].ack, offset=pack['TCP'].dataofs, window_size=pack['TCP'].window,
                               csum=pack['TCP'].chksum)
                pkt.add_protocol(tcps)
                pkt.serialize()
                lists.append(pkt)
                if len(lists) > self.splitlength:
                    self.writeIPv6PacketToFileForRyu(lists)
                    lists.clear()
                else:
                    self.writeIPv6PacketToFileForRyu(lists)
                    lists.clear()

    '''
        write packet to file for ryu
    '''
    def writeIPv6PacketToFileForRyu(self,lists,path = "/home/mao/Mao/Documents/packets.txt"):
        with open(path,'ab') as f:
            for i in lists:

                f.write(i)
                f.write(bytearray("#####".encode()))

    '''
        read Packet from file for ryu
    '''
    def readIPv6PackFromFileForRyu(self,path = "/home/mao/Mao/Documents/packets.txt"):
        with open(path,'rb') as f:
            lines = f.readlines()
            alllen = len(lines)
            i = 0
            kk = b''
            while i<alllen:
                if b'\x1aj' in lines[i]:
                    if len(kk)>10:
                        p = packet.Packet(kk)
                        print(p)
                    kk = lines[i]
                else:
                    kk+=lines[i]
                i+=1


    '''
        将ipv4转换成ipv6
        @ param ipv4 ipv4
        @ return ipv6
    '''
    def Ipv4ToIpv6(self, ipv4):

        chars = self.IPv4StringToBin(ipv4)
        ipv6 = "2001:00:00:00:00:00:"
        i = 0
        while True:
            bin = "" + chars[i] + chars[i + 1] + chars[i + 2] + chars[i + 3]
            ipv6 += self.BinToHx(bin)
            bin = "" + chars[i + 4] + chars[i + 5] + chars[i + 6] + chars[i + 7]
            ipv6 += self.BinToHx(bin)
            bin = "" + chars[i + 8] + chars[i + 9] + chars[i + 10] + chars[i + 11]
            ipv6 += self.BinToHx(bin)
            bin = "" + chars[i + 12] + chars[i + 13] + chars[i + 14] + chars[i + 15]
            ipv6 += self.BinToHx(bin)
            ipv6 += ":"
            i+=16
            if(i>=32):
                break
        return ipv6[:-1]

    '''
        将二进制转换成16进制
        @ param ipv4 二进制
        @return 十六进制
    '''
    def BinToHx(self, ipv4):
        if ipv4 == "0000":
            return "0"
        elif ipv4 == "0001":
            return "1"
        elif ipv4 == "0010":
            return "2"
        elif ipv4 == "0011":
            return "3"
        elif ipv4 == "0100":
            return "4"
        elif ipv4 == "0101":
            return "5"
        elif ipv4 == "0110":
            return "6"
        elif ipv4 == "0111":
            return "7"
        elif ipv4 == "1000":
            return "8"
        elif ipv4 == "1001":
            return "9"
        elif ipv4 == "1010":
            return "a"
        elif ipv4 == "1011":
            return "b"
        elif ipv4 == "1100":
            return "c"
        elif ipv4 == "1101":
            return "d"
        elif ipv4 == "1110":
            return "e"
        elif ipv4 == "1111":
            return "f"
        else:
            return ""

    '''
        String类型的ipv4转换成二进制
        @ param ipv4 String类型的ipv4
        @return 二进制类型的ipv4
    '''

    def IPv4StringToBin(self, ipv4):

        split = ipv4.split(".")
        ipv4Bin = ""
        for i in split:
            k = int(i)
            intlist = []
            while (k > 0):
                intlist.append(k % 2)
                k = int(k/2)
            intlist.reverse()
            if len(intlist) < 8:
                k = 8 - len(intlist)
                s = ""
                for j in range(k):
                    s += "0"
                for j in range(len(intlist)):
                    s += str(intlist[j])
                ipv4Bin += s
            else:
                s = ""
                for j in range(len(intlist)):
                    s += str(intlist[j])
                ipv4Bin += s
        return ipv4Bin

'''
    send packets
'''
class SendPackets():
    def __init__(self,interface,proto=0x0800,path="/home/mao/Mao/Documents/SaiErNetworkPcap/"):
        self.interface = interface
        self.proto = proto
        self.basepath = path
        pass

    '''
        send packets for dir
    '''
    def send(self):
        sockets = socket.socket(family=socket.PF_PACKET, type=socket.SOCK_RAW, proto=socket.htons(self.proto))
        sockets.bind((self.interface, socket.htons(self.proto)))
        kk = os.listdir(self.basepath)
        for i in kk:
            print("loading packets..")
            packets = rdpcap(self.basepath+i)
            for i in range(len(packets)):
                sockets.send(bytes(packets[i]))

    '''
        send packets for a special path
    '''
    def sendForSpecialPath(self):
        sockets = socket.socket(family=socket.PF_PACKET, type=socket.SOCK_RAW, proto=socket.htons(self.proto))
        sockets.bind((self.interface, socket.htons(self.proto)))
        print("loading packets..")
        packets = rdpcap(self.basepath)
        for i in range(len(packets)):
            sockets.send(bytes(packets[i]))

'''
    make big pcap file to many small pcap file.
'''
def handlerPcapPackets():
    packets = rdpcap("/home/mao/Mao/Documents/SaiErNetworkPcap/srcpcap/hping3Catch.pcap")
    lists = []
    i = 0
    for p in packets:
        lists.append(p)
        if len(lists)>=100:
            wrpcap("/home/mao/Mao/Documents/SaiErNetworkPcap/srcpcap/hping3Catch%s.pcap"%i,lists)
            i+=1
            lists.clear()

'''
    clear the file for current time.
    if your ip is not change, you will not to excute this code.
'''
def clearDir(path="/home/mao/Mao/Documents/SaiErNetworkPcap/targetpcap/"):
    files = os.listdir(path=path)
    for f in files:
        os.remove(path+f)

'''
    sys.argv[1]  interface  like ens33, h1-eth0
    sys.argv[2]  special ip you set like "192.168.2.1",you need to give the "",
                    not like 192.168.127.1,you must like this form that "192.168.127.1"
'''
if __name__ == '__main__':
    # handlerPcapPackets()
    clearDir()
    testThread(interface=sys.argv[1],targetIP=sys.argv[2]).start()
    # testThread(interface="ens33",targetIP="10.0.0.1").start()
    # dev = sys.argv[1]
    # sp = SendPackets(dev)
    # sp.send()
    # handlerPcapPackets()