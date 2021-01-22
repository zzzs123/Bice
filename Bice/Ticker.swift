//
//  Ticker.swift
//  Bice
//
//  Created by some on 2021/1/22.
//

import Cocoa
import ObjectMapper

//{
//  "e": "24hrTicker",  // 事件类型
//  "E": 123456789,     // 事件时间
//  "s": "BNBUSDT",      // 交易对
//  "p": "0.0015",      // 24小时价格变化
//  "P": "250.00",      // 24小时价格变化(百分比)
//  "w": "0.0018",      // 平均价格
//  "c": "0.0025",      // 最新成交价格
//  "Q": "10",          // 最新成交价格上的成交量
//  "o": "0.0010",      // 24小时内第一比成交的价格
//  "h": "0.0025",      // 24小时内最高成交价
//  "l": "0.0010",      // 24小时内最低成交加
//  "v": "10000",       // 24小时内成交量
//  "q": "18",          // 24小时内成交额
//  "O": 0,             // 统计开始时间
//  "C": 86400000,      // 统计关闭时间
//  "F": 0,             // 24小时内第一笔成交交易ID
//  "L": 18150,         // 24小时内最后一笔成交交易ID
//  "n": 18151          // 24小时内成交数
//}
//{
//  "e": "24hrTicker",  // Event type
//  "E": 123456789,     // Event time
//  "s": "BTCUSDT",     // Symbol
//  "p": "0.0015",      // Price change
//  "P": "250.00",      // Price change percent
//  "w": "0.0018",      // Weighted average price
//  "c": "0.0025",      // Last price
//  "Q": "10",          // Last quantity
//  "o": "0.0010",      // Open price
//  "h": "0.0025",      // High price
//  "l": "0.0010",      // Low price
//  "v": "10000",       // Total traded base asset volume
//  "q": "18",          // Total traded quote asset volume
//  "O": 0,             // Statistics open time
//  "C": 86400000,      // Statistics close time
//  "F": 0,             // First trade ID
//  "L": 18150,         // Last trade Id
//  "n": 18151          // Total number of trades
//}
class Ticker: Mappable {
    var e: String = ""
    var E: Int16 = 0
    var s: String = ""
    var c: String = ""

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        e <- map["username"]
        E <- map["age"]
        s <- map["weight"]
        c <- map["arr"]
    }
    

}
