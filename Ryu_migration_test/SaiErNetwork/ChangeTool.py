import math
from netaddr import *

class ChangeTool():
    def __init__(self):
        self.map = {
            '0': "0000",
            '1': "0001",
            '2': "0010",
            '3': "0011",
            '4': "0100",
            '5': "0101",
            '6': "0110",
            '7': "0111",
            '8': "1000",
            '9': "1001",
            'a': "1010",
            'b': "1011",
            'c': "1100",
            'd': "1101",
            'e': "1110",
            'f': "1111",
        }

    '''
        ::1
        2001::a00:1
    '''
    def IPv6ToLong(self,i6):
        return IPNetwork(i6).ipv6().value
        # i6s = i6.split(":")
        # lists = []
        # i6long = ""
        # if len(i6s)>0:
        #     for i in i6s:
        #         if i is not '':
        #             lists.append(i)
        #     i = 0
        #     while i<len(i6s):
        #         v = i6s[i]
        #         if v == '':
        #             i+=1
        #             break
        #         temp  =""
        #         for j in v:
        #             temp += self.map[j]
        #         if len(temp)<4:
        #             for j in range(4-len(temp)):
        #                 i6long+="0"
        #             i6long+=temp
        #         else:
        #             temp = ""
        #             for j in v:
        #                 temp += self.map[j]
        #             i6long += temp
        #         i+=1
        #
        #     for j in range(8-len(lists)):
        #         i6long+="0000"
        #
        #     while i<len(i6s):
        #         v = i6s[i]
        #         if v is not '':
        #             temp = ""
        #             for j in v:
        #                 temp += self.map[j]
        #             if len(temp) < 4:
        #                 for j in range(4 - len(temp)):
        #                     i6long += "0"
        #                 i6long += temp
        #             else:
        #                 temp = ""
        #                 for j in v:
        #                     temp += self.map[j]
        #                 i6long += temp
        #         i+=1
        # return int(i6long)
    def binToTen(self,bin):
        i = len(bin) - 1
        res = 0
        exp = 1
        while i>=0:
            res += (int(bin[i]))*exp
            i -= 1
            exp *= 2
        return res


    def ipv6Extend(self,ipv6):
        i6s = ipv6.split(":")
        lists = []
        i6long = ""
        if len(i6s)>0:
            for i in i6s:
                if i is not '':
                    lists.append(i)
            i = 0
            while i<len(i6s):
                v = i6s[i]
                if v == '':
                    i+=1
                    break
                temp  =""
                for j in v:
                    temp += self.map[j]
                if len(temp)<16:
                    for j in range(4-int((len(temp))/4)):
                        i6long+="0000"
                    i6long+=temp
                else:
                    temp = ""
                    for j in v:
                        temp += self.map[j]
                    i6long += temp
                i+=1

            for j in range(8-len(lists)):
                i6long+="0000000000000000"

            while i<len(i6s):
                v = i6s[i]
                if v is not '':
                    temp = ""
                    for j in v:
                        temp += self.map[j]
                    if len(temp) < 16:
                        for j in range(4 - int((len(temp))/4)):
                            i6long += "0000"
                        i6long += temp
                    else:
                        temp = ""
                        for j in v:
                            temp += self.map[j]
                        i6long += temp
                i+=1
        res = 0
        x1 = 0
        x2 = 31
        while x2<128:
            res += self.binToTen(i6long[x1:x2])
            x1 += 32
            x2 += 32
        return res



    def Ipv6ToIpv4(self, ipv6):
        i6s = ipv6.split(':')
        i6s[0] = ''
        res = ""
        for tmp in i6s:
            res += tmp + ':'
        res = res.rstrip(':')
        ipv4_str = IPNetwork(res).ipv4().value
        return ipv4_str
        # return IPNetwork(ipv4_str).ipv4().value

# if __name__ == "__main__":
#     changeTool = ChangeTool()
#     st1 = changeTool.Ipv6ToIpv4('2001::a00:1')
#     st = changeTool.ipv6Extend('2001::a00:1')
#     print(len(str(st)))
#     print((st , st1))