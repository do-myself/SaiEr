import socket
import logging
import contextlib
from ryu.lib import hub
from ryu.lib.hub import StreamServer
import clients
logging.basicConfig()
log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

socketlist = []
socketbind={}

class ServerTets(object):
    def __init__(self):
        super(ServerTets, self).__init__()
        self.ServerSocket = socket.socket()
        self.server = StreamServer(('0.0.0.0', 8888), self.WaitTheClientConnected)



    def WaitTheClientConnected(self, socket, address):
        print('connected address:%s' % str(address))
        # socketlist.append(address)
        print(socket)
        with contextlib.closing(Client(socket)) as client:
            client.server = self

            print(socketbind)
            client.start()
            hub.spawn(clients.ServerTest2(8889))
        pass

    def start(self):
        # hub.spawn(self.monitor)
        print("Server start...")

        hub.spawn(self.server.serve_forever(socketlist))

    def monitor(self):
        while True:
            # print("current topo is :")
            hub.sleep(2)

class ServerTets1(object):
    def __init__(self):
        super(ServerTets1, self).__init__()
        self.ServerSocket = socket.socket()
        self.server = StreamServer(('0.0.0.0', 8889), self.WaitTheClientConnected)

    def WaitTheClientConnected(self, socket, address):
        print('connected address:%s' % str(address))
        # socketlist.append(address)

    def start(self):
        # hub.spawn(self.monitor)
        print("Server start...")
        hub.spawn(self.server.serve_forever(socketlist))

    def monitor(self):
        while True:
            # print("current topo is :")
            hub.sleep(2)

class Client(object):
    def __init__(self, socket):
        super(Client, self).__init__()
        self.send_queue = hub.Queue(32)  # controller and server send message
        self.status = True
        self.server = None  # connect to server
        self.socket = socket
        self.client_id = 0
        self.singletopo = {}
        self.alltopo = {}
        self.slice = {}

    #make data into queue to send
    def send(self, msg):
        if self.send_queue:
            self.send_queue.put(msg)

    def send_msg(self):
        try:
            while self.status:
                while self.send_queue.qsize()>0:
                    message = str(self.send_queue.get())
                    # print("send message : ")
                    # print(message)
                    message += '\n'
                    msg = bytes(message.encode())
                    print(socketlist)
                    for i in range(len(socketlist)):
                        if i % 2 == 0:
                            try:
                                socket = socketlist[i]
                                socket.sendall(msg)
                            except:
                                del socketlist[i]
                self.send_queue = hub.Queue(32)
                hub.sleep(2)

        finally:  # disconnect
            self.send_queue = None

    def rece_msg(self):
        while self.status:
            try:
                message = self.socket.recv(128).decode()
                # print(message)
                # if len(message) == 1:
                #     #reply
                #     hub.spawn(self.helloreply)
                    # fc.getalltopo(self.server.topo)
                if len(message) == 0:
                    log.info("connection failed")
                    self.status = False
                    break
                else:
                    if len(message)>0:
                        self.handlermessage(str(message))
                    # if len(message) <2:
                    #     return
                    # self.handlermessage(str(message))
                hub.sleep(0.1)
            except ValueError:
                print('Value error for %s, len: %d', message, len(message))

    # def helloreply(self):
    #     message = '2'
    #     self.socket.sendall(bytes(message.encode()))
    #     # print("send sucess")


    def handlermessage(self,message):
        #'\n' is the end of the message

        while '\n' != message[-1]:
            try:
                tempmess = self.socket.recv(128).decode()
                message += tempmess
            except:
                break
        # print(message)
        print("mesage : "+message)
        # if '\n' in message:
        #     data = message.split("\n")
        #     self.forhandlermessage(data)
        #     return

    def forhandlermessage(self,data):
        for temp in data:
            if len(temp) <= 30:
                continue
            # try:
            msg = eval(temp)
            print(msg)
            # if msg['MessageType'] == 'normal':
            #     # msg = json.loads(temp)  # analyze message
            #     # print(msg)
            #     # self.handlerNormalmessage(msg)
            # elif msg['MessageType'] != 'normal':
            #     # print("message is :%s,messagetype is %s",msg,msg['MessageType'])
            #     # ,[self.singletopo,self.alltopo,self.slice]
            #     # ma.MessageHandlerAdapater(self.send_queue,msg,self.client_id)
            # else:
            #     pass

                #对于从控制器发来的数据服务器目前来说是无条件转发
            # except:
            #     print("normal message transform failure")

    # def handlerNormalmessage(self,msg):
    #     if msg['cmd'] == 'add_topo':
    #         dst_dpid = msg['dst_dpid']
    #         dst_port_no = msg['dst_port_no']
    #         src_dpid = msg['src_dpid']
    #         src_port_no = msg['src_port_no']
    #         print(msg)
    #         if (src_dpid, dst_dpid) not in self.server.topo.keys():
    #             self.server.topo[(src_dpid, dst_dpid)] = (src_port_no, dst_port_no)
    #             # fc.hadlersinglertopo(str(msg),[self.singletopo])
    #             print("Add topo :", src_dpid, dst_dpid, ":", src_port_no, dst_port_no)
    #             fc.getalltopo(self.server.topo)
    #
    #         # self.send(str(msg))


    def start(self):
        t1 = hub.spawn(self.send_msg)
        t2 = hub.spawn(self.rece_msg)
        hub.joinall([t1, t2])

    def close(self):
        self.status = False
        self.socket.close()


# class ConnectedRemoteServer():
#     def __init__(self):
#         super(ConnectedRemoteServer, self).__init__()
#         self.clientsocket = socket.socket()
#
#     def connectedRemoteServer(self):
#         self.clientsocket.connect(("127.0.0.1",8889))
#
#
#     def AddToQueue(self):
#         pass
#
#     def ChangeTheFormate(self):
#         pass
#
#     def SendMessage(self):
#         pass
#
#     def ReceiveMessage(self):
#         pass
#
#     def MessageHandler(self):
#         pass

def main():


    ServerTets().start()
    # hub.spawn(clients.ServerTest2(8889))


if __name__ == '__main__':
    main()