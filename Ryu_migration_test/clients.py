import socket
from ryu.lib import hub

class ServerTest2(object):
    def __init__(self,port):
        super(ServerTest2, self).__init__()
        self.clientsocket = socket.socket()
        self.queue = hub.Queue(32)
        self.connectremoteserver(port)

    def connectremoteserver(self,port):
        while True:
            try:
                self.clientsocket.connect(("127.0.0.1",port))
                hub.spawn(self.sendloop)
                hub.spawn(self.recvloop)
                print("connect success")
                self.sendmsg()
                break
            except:
                pass

        while True:
            hub.sleep(10)

    def sendloop(self):
        while True:
            print(self.queue.qsize())
            while self.queue.qsize() >0:
                t = self.queue.get()
                t+='\n'
                print(t)
                # self.clientsocket.sendall(bytes(str(t).encode()))

            hub.sleep(1)

    def recvloop(self):
        while True:
            msg = self.clientsocket.recv(128).decode()
            if len(msg) == 0:
                print("socket is down")
                break
            else:
                self.msghadler(msg)
            hub.sleep(0.1)

    def msghadler(self,msg):
        while '\n' != msg[-1]:
            try:
                tempmess = self.clientsocket.recv(128).decode()
                msg += tempmess
            except:
                break

            # msg = eval(msg)
            print(msg)

    def addtoqueue(self,msg):
        try:
            print(self.clientsocket.getpeername())
            if self.queue.qsize()<16:
                self.queue.put(msg)
            else:
                print("data is over the queue size")
        except:
            print("socket has not connect")

    def sendmsg(self):
        i = 0
        while i<10:
            self.addtoqueue("client send this to server "+str(i))
            i+=1

if __name__ == '__main__':
    ServerTest2()