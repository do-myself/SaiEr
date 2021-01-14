
from SaiErNetwork.Identify.start import StartIdentify as si
class createPackets():
    def __init__(self,model):
        self.flags = 0
        self.result = self.HandlePackets(model)

    def HandlePackets(self,model):
        result = si(model).result
        return result