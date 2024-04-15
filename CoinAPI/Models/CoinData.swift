//
//  CoinData.swift
//  CoinAPI
//
//  Created by 王佩豪 on 2023/12/29.
//

import Foundation

struct CoinData:Codable{
    var time:String
    var asset_id_base:String
    var asset_id_quote:String
    var rate:Double
}
