
import threading,socket,sys,time

class test(threading.Thread):

    def __init__(self,ip,port):
        super(test, self).__init__()
        print(ip,port)
        self.sock = socket.socket()
        self.sock.bind((ip,port))
        self.sock.listen(1)

    def run(self):
        self.conn, self.address = self.sock.accept()
        while True:
            if self.conn != None:
                resu = self.conn.recv(1024*1024)
                print(resu)
                time.sleep(0.1)

if __name__ == '__main__':
    s3 = test(ip=sys.argv[1],port=int(sys.argv[2]))
    s3.start()