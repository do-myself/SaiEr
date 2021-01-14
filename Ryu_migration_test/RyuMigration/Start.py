# import sys
import socket
# import json
# sys.path.append("/home/manminglei/ryu")
from ryu.base import app_manager
from ryu.controller import ofp_event
from ryu.controller.handler import MAIN_DISPATCHER, DEAD_DISPATCHER
from ryu.controller.handler import CONFIG_DISPATCHER
from ryu.controller.handler import set_ev_cls
from ryu.ofproto import ofproto_v1_3
from ryu.lib.packet import *
from ryu.topology import api
from ryu.lib import hub
import time
from ryu.topology.switches import LLDPPacket
from ryu.lib.packet import Mao
from ryu.topology import event

class starts(app_manager.RyuApp):
    OFP_VERSIONS = [ofproto_v1_3.OFP_VERSION]
    def __init__(self,*kws,**kwargs):
        super(starts, self).__init__(*kws,**kwargs)
        self.dpids = {}
        self.status = True
        self.socket = socket.socket()
        # self.connecttsocket("127.0.0.1",8888)
        self.send_queue = hub.Queue(16)
        self.client_id = 0
        self.mac_to_port={}
        self.lldppacketstimes = 0
        self.times = 0
        self.firstpackets = 0
        self.dpidpackets={}
        self.icmpcount = 0
        self.arpcount = 0
        self.dpstate = {}
        self.count = 0



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
        if buffer_id:
            mod = parser.OFPFlowMod(datapath=datapath, buffer_id=buffer_id,
                                    priority=priority, match=match,
                                    instructions=inst)
        else:
            mod = parser.OFPFlowMod(datapath=datapath, priority=priority,
                                    match=match, instructions=inst)
        datapath.send_msg(mod)

    @set_ev_cls(event.EventPortModify,[MAIN_DISPATCHER,CONFIG_DISPATCHER])
    def handlerportmodify(self,ev):
        self.firstpackets = 0

    @set_ev_cls(ofp_event.EventOFPPacketIn, MAIN_DISPATCHER)
    def handlerPacketIn(self,ev):
        pkt = packet.Packet()
        eth_pkt = ethernet.ethernet(dst="00:00:00:00:00:01", src="00:00:00:00:00:02", ethertype=ether_types.ETH_TYPE_IP)
        pkt.add_protocol(eth_pkt)
        print(pkt)
        print("//////////////////////////")

        msg = ev.msg
        datapath = msg.datapath

        pkt = packet.Packet(msg.data)
        ldp = pkt.get_protocol(lldp.lldp)

        if ldp:
            src, srcport = LLDPPacket.lldp_parse(msg.data)
            dst_port_no,dst_dpid = msg.match['in_port'],datapath.id
            # self.add_topo(src_dpid=src,dst_dpid=dst_dpid,src_port_no=srcport,dst_port_no=dst_port_no)
        else:

            ofproto = datapath.ofproto
            parser = datapath.ofproto_parser
            pkt = packet.Packet(msg.data)
            eth = pkt.get_protocols(ethernet.ethernet)[0]

            src = eth.src
            dst = eth.dst
            dpid, port = datapath.id, msg.match['in_port']

            ips = pkt.get_protocol(ipv4.ipv4)
            icmps = pkt.get_protocol(icmp.icmp)
            arps = pkt.get_protocol(arp.arp)
            # print(arps,icmps)
            '''
                set the stat of the switch.
            '''
            if dpid not in self.dpstate:
                self.dpstate.setdefault(dpid,{})
                self.dpstate[dpid]['datapath'] = datapath
                self.dpstate[dpid]['state'] = 0
            if dpid == 1 or dpid ==2 or dpid == 3 or dpid ==4:
                if self.dpstate[dpid]['state'] == 0:
                    self.send_role_request(datapath,ofproto.OFPCR_ROLE_MASTER)


            elif dpid == 5 or dpid ==6 or dpid == 7 or dpid ==8:
                if self.dpstate[dpid]['state'] == 0:
                    self.send_role_request(datapath,ofproto.OFPCR_ROLE_SLAVE)

            if self.count == 100:
                self.count = 0
                if self.dpstate[1]['state'] == 2  and 2 in self.dpstate:
                    self.send_flow_stats_request(self.dpstate[1]['datapath'],2)
                    self.send_flow_stats_request(self.dpstate[1]['datapath'], 1)
                    actions = [parser.OFPActionOutput(ofproto.OFPP_CONTROLLER)]
                    match = parser.OFPMatch(in_port=2)
                    self.add_flow(self.dpstate[1]['datapath'], 11, actions=actions, match=match)
                    if self.dpstate[2]['state'] == 2:
                        self.send_role_request(self.dpstate[2]['datapath'], ofproto.OFPCR_ROLE_MASTER)
                # if self.dpstate[1]['state'] == 3:
                #     self.send_role_request(self.dpstate[1]['datapath'], ofproto.OFPCR_ROLE_EQUAL)

            self.count+=1



            actions = [parser.OFPActionOutput(ofproto.OFPP_FLOOD)]


            data = None

            if msg.buffer_id == ofproto.OFP_NO_BUFFER:
                data = msg.data
            out = parser.OFPPacketOut(datapath=datapath, buffer_id=msg.buffer_id,
                                      in_port=port, actions=actions, data=data)
            datapath.send_msg(out)

    def putinqueue(self, msg):
        # clooect the msg
        # print("add to the queue msg is :" + msg)
        if self.send_queue != None:
            # print("add success..........")
            self.send_queue.put(msg)

    def send_role_request(self, datapath,role):
        ofp = datapath.ofproto
        ofp_parser = datapath.ofproto_parser

        # req = ofp_parser.OFPRoleRequest(datapath, ofp.OFPCR_ROLE_SLAVE, 0)
        req = ofp_parser.OFPRoleRequest(datapath,role,0)
        datapath.send_msg(req)

    @set_ev_cls(ofp_event.EventOFPRoleReply, MAIN_DISPATCHER)
    def role_reply_handler(self, ev):
        msg = ev.msg
        dp = msg.datapath
        ofp = dp.ofproto

        if msg.role == ofp.OFPCR_ROLE_NOCHANGE:
            role = 'NOCHANGE'
            self.dpstate[dp.id]['state'] = 0
        elif msg.role == ofp.OFPCR_ROLE_EQUAL:
            role = 'EQUAL'
            self.dpstate[dp.id]['state'] = 1
        elif msg.role == ofp.OFPCR_ROLE_MASTER:
            role = 'MASTER'
            self.dpstate[dp.id]['state'] = 2
        elif msg.role == ofp.OFPCR_ROLE_SLAVE:
            role = 'SLAVE'
            self.dpstate[dp.id]['state'] = 3
        else:
            role = 'unknown'
            self.dpstate[dp.id]['state'] = -1

        print('OFPRoleReply received: role=%s'%role)
        print('generation_id=%d'%dp.id)
        if dp.id == 3 and self.dpstate[dp.id]['state'] == 2:
            self.excuteMigrate(3, ofp)

        print(self.dpstate)


    def excuteMigrate(self,dpid,ofproto):
        if dpid in self.dpstate:
            # if self.dpstate[dpid]['state'] == ofproto.OFPCR_ROLE_SLAVE:
            self.send_role_request(self.dpstate[dpid]['datapath'], ofproto.OFPCR_ROLE_SLAVE)

    @set_ev_cls(event.EventPortModify, MAIN_DISPATCHER)
    def switchportmodify(self, ev):
        self.topoischanges = 1
        print(str(ev))

    def send_flow_stats_request(self, datapath,port):
        ofp = datapath.ofproto
        ofp_parser = datapath.ofproto_parser

        cookie = cookie_mask = 0
        match = ofp_parser.OFPMatch(in_port=port)
        req = ofp_parser.OFPFlowStatsRequest(datapath, 0,
                                             ofp.OFPTT_ALL,
                                             ofp.OFPP_ANY, ofp.OFPG_ANY,
                                             cookie, cookie_mask,
                                             match)
        datapath.send_msg(req)

    @set_ev_cls(ofp_event.EventOFPFlowStatsReply, MAIN_DISPATCHER)
    def flow_stats_reply_handler(self, ev):
        flows = []
        for stat in ev.msg.body:
            flows.append('table_id=%s '
                         'duration_sec=%d duration_nsec=%d '
                         'priority=%d '
                         'idle_timeout=%d hard_timeout=%d flags=0x%04x '
                         'cookie=%d packet_count=%d byte_count=%d '
                         'match=%s instructions=%s' %
                         (stat.table_id,
                          stat.duration_sec, stat.duration_nsec,
                          stat.priority,
                          stat.idle_timeout, stat.hard_timeout, stat.flags,
                          stat.cookie, stat.packet_count, stat.byte_count,
                          stat.match, stat.instructions))
        print('FlowStats: %s', flows)
