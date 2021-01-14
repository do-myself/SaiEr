from keras.models import model_from_json
from pandas import read_csv
from sklearn.preprocessing import Normalizer
from numpy import expand_dims,zeros
from SaiErNetwork.Identify.Config import *
from numpy import argmax
class StartIdentify():
    def __init__(self,model=None,data=None):
        if data != None:
            self.data = data

        if model != None:
            y = self.getData()
            self.result = self.getResult(y,model)

    def getData(self,path = rootdir+'test23.csv'):
        test_data = read_csv(rootdir+"test23.csv", header=None)
        # # 测试集测试部分
        test = test_data.iloc[:, 0:15]
        # # 测试集的归一化操作
        scaler = Normalizer().fit(test)
        x_test = scaler.transform(test)
        # # 获取测试集，没有标签
        y = expand_dims(x_test, axis=2)
        return y

    def getResult(self,y,model):
        # 预测，返回一个列表，其中包含最大值---结果位置
        list = model.predict(y)
        # print(list)
        # 测试单个
        k = max(list[0])
        # print(k)
        # 1.7390638e-03
        for i in range(len(list[0])):
            if list[0][i] == k:
                return i

    def SaveResult(self):
        results = str(self.data)+"  "+str(self.result)
        with open(rootdir+"/Result.txt",'a') as file:
            file.write(results)
            file.write('\n')


    def Strtolist(self,list):
        TeZheng = list.split(',')
        return TeZheng


def LoadModel():
    # 读取json模式的model
    my_model = model_from_json(open(rootdir+'Network_Mode_Json1.json').read())
    # 读取权重
    my_model.load_weights(rootdir+'Network_Mode_Weight1.h5')

    my_model.predict(StartIdentify().getData(path=rootdir+'test234.csv'))
    return my_model
