//
//  CoinApiManager.swift
//  CoinAPI
//
//  Created by 王佩豪 on 2023/12/29.
//

import Foundation


protocol CoinApiManagerDlegate{
    func didUpdateRate(_ coinApiManager:CoinApiManager, coinModel:CoinModel)
    func didFailWithError(error:Error)
}


struct CoinApiManager{
    let CoinApiurl = "https://rest.coinapi.io/v1/exchangerate/"
    let apikey = "7F86D40B-DC91-4150-AFA7-04E6D5B69FE9"
    
    var delegate:CoinApiManagerDlegate?
    
    
    func fetchCoinRate(target:String) {
        let urlString = "\(CoinApiurl)\(target)?apikey=\(apikey)"
        print("正在使用fetchCoinRate")
        //在这里调用函数不需要写self的原因是performRequest函数就在weatherManager里面，这是显而易见的，swift为我们自动连接了
        performRequest(with: urlString)
    }
    
    //联网请求的四个步骤
    func performRequest(with urlString:String){
        print("进入performRequest")
        //1. create a url
        guard let url = URL(string: urlString) else { return  }
        //2. create a session
        let session = URLSession(configuration: .default)
        //3. give the session a task
        let task = session.dataTask(with: url){(data,response,error) in
            
            if error != nil{
                //这里调用一个viewController 协议里边的更新函数，接到函数之后传递到新的页面中
                //这个地方的 error as！需要看一下
                self.delegate?.didFailWithError(error: Error.self as! Error)
                return
            }
                if let safeData = data {
                    //现在是在一个闭包里面调用函数，调用函数我们就需要添加单词self
                    if let coin = self.parseJSON(safeData){
                        //parseJSON返回的CoinModel对象名字是
                        print(coin.coinRateString)
                        self.delegate?.didUpdateRate(self, coinModel: coin)
                        print("newWorking已完成")
                }
            }
        }
        //4. run the task
        task.resume()
    }
    
    func parseJSON(_ CoinDate:Data)->CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinData.self, from: CoinDate)
            let time = decodeData.time
            let target = decodeData.asset_id_base
            let standard = decodeData.asset_id_quote
            let rate = decodeData.rate
            print(rate)
            let coinRate = CoinModel(applyTime: time, coinTarget: target, coinStandard: standard, coinRate: rate)
            
            //返回 coinModel
            print("JSON数据解析完成")
            return coinRate
            
        }catch{
            //委托调用主页中的错误函数
            self.delegate?.didFailWithError(error:error)
            return nil
        }
    }
}
