//
//  CoinModel.swift
//  CoinAPI
//
//  Created by 王佩豪 on 2023/12/29.
//

import Foundation

struct CoinModel{
    let applyTime:String
    let coinTarget:String
    let coinStandard:String
    let coinRate:Double
    
    var coinRateString:String{
        return String(format: "%.3f",coinRate)
    }
}
