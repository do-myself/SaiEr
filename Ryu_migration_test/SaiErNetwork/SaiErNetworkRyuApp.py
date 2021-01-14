from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import CONFIG_DISPATCHER, MAIN_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import packet,ipv6,ipv4,icmpv6,tcp,udp
from ryu.lib.packet import ethernet
from ryu.lib.packet import ether_types
from ryu.topology import api,event
from ryu.lib.packet.icmpv6 import nd_neighbor
from netaddr import *
import sys,os
sys.path.append("/root/PycharmProjects/Ryu_migration_test/SaiErNetwork/")
from SaiErNetwork.Identify.start_server import *
from SaiErNetwork.ChangeTool import ChangeTool
import threading,time
ct = ChangeTool()

lock = threading.Lock()
lock2 = threading.Lock()

class SaiErNetworkRyuApp(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]

    def __init__(self):
        super(SaiErNetworkRyuApp, self).__init__()
        self.mac_to_port = {}
        self.ipv6_mac = {}
        self.handlist = []
        self.dps = {} # {dpid->dp}
        self.allswitches = {}  #{dpid->{port_no:port}}
        self.src_dpid_port = {} # {src->[dpid,port_no]}
        self.rm = RecvMessage()
        # self.rm.open()
        self.rm.recvMessage(self.handlist)
        HandlePortDown(self.dps,self.allswitches).start()


    @set_ev_cls(ofp_event.EventOFPSwitchFeatures, CONFIG_DISPATCHER)
    def switch_features_handler(self, ev):
        datapath = ev.msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        match = parser.OFPMatch()
        actions = [parser.OFPActionOutput(ofproto.OFPP_CONTROLLER,
                                          ofproto.OFPCML_NO_BUFFER)]
        self.add_flow(datapath, 0, match, actions)

    def add_flow(self, datapath, priority, match, actions, buffer_id=None):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        inst = [parser.OFPInstructionActions(ofproto.OFPIT_APPLY_ACTIONS,
                                             actions)]

        mod = parser.OFPFlowMod(datapath=datapath, priority=priority,
                                    match=match, instructions=inst)
        datapath.send_msg(mod)

    @set_ev_cls(event.EventSwitchEnter,MAIN_DISPATCHER)
    def handleSwitchEnter(self,ev):
        switchs = api.get_all_switch(self)
        '''
            self.dp = dp
            self.ports = []
            {dpid->{"switch"->switch,"ports":{port_no:port}}}
        '''
        lock2.locked()
        for switch in switchs:
            dpid = switch.dp.id
            if dpid not in self.allswitches:
                self.allswitches.setdefault(dpid,{})
                for p in switch.ports:
                    self.allswitches[dpid][p.port_no] = p
        lock2.release()



    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def _packet_in_handler(self, ev):
        msg = ev.msg
        datapath = msg.datapath
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser
        in_port = msg.match['in_port']

        pkt = packet.Packet(msg.data)
        eth = pkt.get_protocols(ethernet.ethernet)[0]

        if eth.ethertype == ether_types.ETH_TYPE_LLDP:
            # ignore lldp packet
            return
        dst = eth.dst
        src = eth.src

        dpid = datapath.id
        self.mac_to_port.setdefault(dpid, {})

        if dpid not in self.dps:
            lock.locked()
            self.dps[dpid] = datapath
            lock.release()

        # learn a mac address to avoid FLOOD next time.
        self.mac_to_port[dpid][src] = in_port

        if dst in self.mac_to_port[dpid]:
            out_port = self.mac_to_port[dpid][dst]
        else:
            out_port = ofproto.OFPP_FLOOD

        actions = [parser.OFPActionOutput(out_port)]
        i6 = pkt.get_protocol(ipv6.ipv6)
        i4 = pkt.get_protocol(ipv4.ipv4)
        if i6 or i4:
            tcps = pkt.get_protocol(tcp.tcp)
            udps = pkt.get_protocol(udp.udp)
            if i4:
                i4src = i4.src
                i4dst = i4.dst
                if tcps:
                    self.change(dpid,in_port,src,dst,i6,tcps)
                    if out_port != ofproto.OFPP_FLOOD:
                        match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src,eth_type=ether_types.ETH_TYPE_IP,
                                                ipv6_src = i4src,ipv6_dst = i4dst,ip_proto = ipv4.inet.IPPROTO_TCP,
                                                tcp_src = tcps.src_port,tcp_dst = tcps.dst_port)
                        # verify if we have a valid buffer_id, if yes avoid to send both
                        # flow_mod & packet_out
                        if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                            self.add_flow(datapath, 2, match, actions, msg.buffer_id)
                            return
                        else:
                            self.add_flow(datapath, 2, match, actions)
                elif udps:
                    self.change(dpid, in_port, src, dst, i6, tcps)
                    if out_port != ofproto.OFPP_FLOOD:
                        match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src,
                                                eth_type=ether_types.ETH_TYPE_IPV6,
                                                ipv6_src=i4src, ipv6_dst=i4dst,ip_proto = ipv4.inet.IPPROTO_UDP,
                                                udp_src = udps.src_port,udp_dst = udps.dst_port)
                        # verify if we have a valid buffer_id, if yes avoid to send both
                        # flow_mod & packet_out
                        if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                            self.add_flow(datapath, 2, match, actions, msg.buffer_id)
                            return
                        else:
                            self.add_flow(datapath, 2, match, actions)
                else:
                    '''
                        ipv4_src         IPv4 address    IPv4 source address
                        ipv4_dst         IPv4 address    IPv4 destination address
                    '''
                    # install a flow to avoid packet_in next time
                    if out_port != ofproto.OFPP_FLOOD:
                        match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src,eth_type=ether_types.ETH_TYPE_IP,
                                                ipv4_src = i4src,ipv4_dst = i4dst)
                        # verify if we have a valid buffer_id, if yes avoid to send both
                        # flow_mod & packet_out
                        if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                            self.add_flow(datapath, 2, match, actions, msg.buffer_id)
                            return
                        else:
                            self.add_flow(datapath, 2, match, actions)
            if i6:
                '''
                    ipv6_src         IPv6 address    IPv6 source address
                    ipv6_dst         IPv6 address    IPv6 destination address
                '''
                i6src = i6.src
                i6dst = i6.dst
                if tcps:
                    self.change(dpid,in_port,src,dst,i6,tcps)
                    if out_port != ofproto.OFPP_FLOOD:
                        match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src,eth_type=ether_types.ETH_TYPE_IPV6,
                                                ipv6_src = i6src,ipv6_dst = i6dst,ip_proto = ipv4.inet.IPPROTO_TCP,
                                                tcp_src = tcps.src_port,tcp_dst = tcps.dst_port)
                        # verify if we have a valid buffer_id, if yes avoid to send both
                        # flow_mod & packet_out
                        if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                            self.add_flow(datapath, 2, match, actions, msg.buffer_id)
                            return
                        else:
                            self.add_flow(datapath, 2, match, actions)
                elif udps:
                    self.change(dpid, in_port, src, dst, i6, tcps)
                    if out_port != ofproto.OFPP_FLOOD:
                        match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src,
                                                eth_type=ether_types.ETH_TYPE_IPV6,
                                                ipv6_src=i6src, ipv6_dst=i6dst,ip_proto = ipv4.inet.IPPROTO_UDP,
                                                udp_src = udps.src_port,udp_dst = udps.dst_port)
                        # verify if we have a valid buffer_id, if yes avoid to send both
                        # flow_mod & packet_out
                        if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                            self.add_flow(datapath, 2, match, actions, msg.buffer_id)
                            return
                        else:
                            self.add_flow(datapath, 2, match, actions)
                else:
                    # # install a flow to avoid packet_in next time
                    if out_port != ofproto.OFPP_FLOOD:
                        match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src,eth_type=ether_types.ETH_TYPE_IPV6,
                                                ipv6_src = i6src,ipv6_dst = i6dst)
                        # verify if we have a valid buffer_id, if yes avoid to send both
                        # flow_mod & packet_out
                        if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                            self.add_flow(datapath, 2, match, actions, msg.buffer_id)
                            return
                        else:
                            self.add_flow(datapath, 2, match, actions)
        else:
            # install a flow to avoid packet_in next time
            if out_port != ofproto.OFPP_FLOOD:
                match = parser.OFPMatch(in_port=in_port, eth_dst=dst, eth_src=src)
                # verify if we have a valid buffer_id, if yes avoid to send both
                # flow_mod & packet_out
                if msg.buffer_id != ofproto.OFP_NO_BUFFER:
                    self.add_flow(datapath, 1, match, actions, msg.buffer_id)
                    return
                else:
                    self.add_flow(datapath, 1, match, actions)
        data = None
        if msg.buffer_id == ofproto.OFP_NO_BUFFER:
            data = msg.data

        out = parser.OFPPacketOut(datapath=datapath, buffer_id=msg.buffer_id,
                                  in_port=in_port, actions=actions, data=data)
        datapath.send_msg(out)


    def change(self,dpid,in_port,srcmac,dstmac,i6,tcps):
        ipv6src, ipv6dst = i6.src,i6.dst
        results = str(dpid)+","+str(in_port)+","+str(srcmac)+","+str(dstmac)+","+str(ipv6src)+","+str(ipv6dst)+"#####"
        if i6.nxt == ipv4.inet.IPPROTO_TCP:
            flag = tcps.bits
            flaglist = []

            if flag>0:
                while flag>0:
                    flaglist.append(flag%2)
                    flag/=2
            else:
                for i in range(6):
                    flaglist.append(0)

            if len(ipv6dst)>9 or len(ipv6src)>9:
                results+= str(ct.ipv6Extend(ipv6src))+","+\
                          str(tcps.src_port)+","+str(ct.ipv6Extend(ipv6dst))+\
                          ","+str(tcps.dst_port)+",6"+",0,"+str(len(tcps))+","+str(len(tcps))+","+\
                          str(len(tcps))+","+str(len(tcps))+","+str(flaglist[0])\
                          +","+str(flaglist[1])+","+str(flaglist[2])+","+str(flaglist[3])\
                          +","+str(flaglist[4])+","+str(flaglist[5])

                if len(results)>0:
                    self.handlist.append(results)


class HandlePortDown(threading.Thread):
    def __init__(self,dps,switches):
        super(HandlePortDown, self).__init__()
        self.dps = dps
        self.switches = switches

    def run(self) -> None:
        while True:
            if len(self.dps)>0:

                # /home/mao/Mao/Documehnts/check.txt
                if os.path.exists("/home/mao/Mao/Documents/check.txt"):
                    with open("/home/mao/Mao/Documents/check.txt", 'r') as f:

                        lists = f.readlines()
                        for i in lists:
                            # print(i)
                            kk = i.split(",")
                            dpid = int(kk[0])
                            in_port = int(kk[1])
                            if dpid in self.dps:
                                dp = self.dps[dpid]
                                ofp = dp.ofproto
                                parser = dp.ofproto_parser
                                actions = [parser.OFPActionOutput(10)]
                                match = parser.OFPMatch(in_port=in_port)
                                self.add_flow(dp,3,match,actions)
                                # print("flows send successfully!")
                else:
                    print("file not exists")

                if os.path.exists("/home/mao/Mao/Documents/addFlow.txt"):
                    with open("/home/mao/Mao/Documents/addFlow.txt", 'r') as f1:

                        lists = f1.readlines()
                        for i in lists:
                            kk = i.split(",")
                            tmp = kk[1].split(":")
                            dpid = int(tmp[7])
                            in_port = int(kk[3])
                            if dpid in self.dps:
                                dp = self.dps[dpid]
                                ofp = dp.ofproto
                                parser = dp.ofproto_parser
                                actions = [parser.OFPActionOutput(10)]
                                match = parser.OFPMatch(in_port=in_port)
                                self.add_flow(dp, 3, match, actions)
                                # print("flows send successfully!")

                    # with open("/home/mao/Mao/Documents/addFlow.txt", 'w') as f2:
                    #     f2.write("")
                else:
                    print("file not exists")

            time.sleep(0.1)
    '''
            self.dpid = dpid
            self._ofproto = ofproto
            self._config = ofpport.config
            self._state = ofpport.state
    
            self.port_no = ofpport.port_no
            self.hw_addr = ofpport.hw_addr
            self.name = ofpport.name
    '''
    def send_port_mod(self, datapath,port_no):
        ofp = datapath.ofproto
        ofp_parser = datapath.ofproto_parser
        while True:
            if datapath.id in self.switches:
                if port_no in self.switches[datapath.id]:
                    break

        hw_addr = self.switches[datapath.id][int(port_no)].hw_addr
        print(hw_addr,datapath.id,port_no)
        config = 0
        mask = (ofp.OFPPC_PORT_DOWN | ofp.OFPPC_NO_RECV |
                    ofp.OFPPC_NO_FWD | ofp.OFPPC_NO_PACKET_IN)
        advertise = (ofp.OFPPF_10MB_HD | ofp.OFPPF_100MB_FD |
                     ofp.OFPPF_1GB_FD | ofp.OFPPF_COPPER |
                     ofp.OFPPF_AUTONEG | ofp.OFPPF_PAUSE |
                     ofp.OFPPF_PAUSE_ASYM)
        req = ofp_parser.OFPPortMod(datapath=datapath, port_no=port_no, hw_addr=hw_addr, config=config,
                                    mask=mask,advertise=advertise)
        datapath.send_msg(req)


    def add_flow(self, datapath, priority, match, actions, buffer_id=None):
        ofproto = datapath.ofproto
        parser = datapath.ofproto_parser

        inst = [parser.OFPInstructionActions(ofproto.OFPIT_APPLY_ACTIONS,
                                             actions)]

        mod = parser.OFPFlowMod(datapath=datapath, priority=priority,
                                    match=match, instructions=inst)
        datapath.send_msg(mod)

