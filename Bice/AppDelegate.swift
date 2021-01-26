//
//  AppDelegate.swift
//  Bice
//
//  Created by silly b on 2021/1/22.
//

import Cocoa
import SwiftUI
import Starscream

@main
class AppDelegate: NSObject, NSApplicationDelegate {

//    var window: NSWindow!

    var label = PriceLabel()
    
//    本篇所列出的所有wss接口baseurl: wss://fstream.binance.com
//    订阅单一stream格式为 /ws/<streamName>
//    组合streams的URL格式为 /stream?streams=<streamName1>/<streamName2>/<streamName3>
//    订阅组合streams时，事件payload会以这样的格式封装 {"stream":"<streamName>","data":<rawPayload>}
//    stream名称中所有交易对均为小写
//    每个链接有效期不超过24小时，请妥善处理断线重连。
//    服务端每5分钟会发送ping帧，客户端应当在15分钟内回复pong帧，否则服务端会主动断开链接。允许客户端发送不成对的pong帧(即客户端可以以高于15分钟每次的频率发送pong帧保持链接)。
//    Websocket服务器每秒最多接受10个订阅消息。
//    如果用户发送的消息超过限制，连接会被断开连接。反复被断开连接的IP有可能被服务器屏蔽。
//    单个连接最多可以订阅 200 个Streams。

    lazy var socket: WebSocket = {
        let url = URL(string: "wss://fstream.binance.com/ws/btcusdt@ticker")!
//        let url = URL(string: "wss://fstream.binance.com/stream?streams=btcusdt@ticker/etcusdt@ticker")!
//        let url = URL(string: "wss://fstream.binance.com/ws/btcusdt@markPrice@1s")!
//        let url = URL(string: "wss://stream.binance.com:9443/ws/!ticker@arr")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5 // Sets the timeout for the connection
        //        request.setValue("someother protocols", forHTTPHeaderField: "Sec-WebSocket-Protocol")
        //        request.setValue("14", forHTTPHeaderField: "Sec-WebSocket-Version")
        //        request.setValue("chat,superchat", forHTTPHeaderField: "Sec-WebSocket-Protocol")
        //        request.setValue("Everything is Awesome!", forHTTPHeaderField: "My-Awesome-Header")
        
        let socket = WebSocket(request: request)
        socket.onEvent = { [weak self] event in
            switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
                                
            case .disconnected(let reason, let code):
                //                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                if let data = string.data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
//                    {
//                      "e": "24hrTicker",  // 事件类型
//                      "E": 123456789,     // 事件时间
//                      "s": "BNBUSDT",      // 交易对
//                      "p": "0.0015",      // 24小时价格变化
//                      "P": "250.00",      // 24小时价格变化(百分比)
//                      "w": "0.0018",      // 平均价格
//                      "c": "0.0025",      // 最新成交价格
//                      "Q": "10",          // 最新成交价格上的成交量
//                      "o": "0.0010",      // 24小时内第一比成交的价格
//                      "h": "0.0025",      // 24小时内最高成交价
//                      "l": "0.0010",      // 24小时内最低成交加
//                      "v": "10000",       // 24小时内成交量
//                      "q": "18",          // 24小时内成交额
//                      "O": 0,             // 统计开始时间
//                      "C": 86400000,      // 统计关闭时间
//                      "F": 0,             // 24小时内第一笔成交交易ID
//                      "L": 18150,         // 24小时内最后一笔成交交易ID
//                      "n": 18151          // 24小时内成交数
//                    }
                    let s = json["s"] as! String
                    let c = json["c"] as! String
                    print("Received text: \(c)")
                    self?.label.price = s + ": " + c
//                    let btcusdt = json["btcusdt@ticker"]
                }
                
                
                print("Received text: \(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(let data):
                print("Received ping: \(data?.count)")
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled: break
            //                isConnected = false
            case .error(let error): break
            //                isConnected = false
            //                handleError(error)
            
            }
            
        }
        //        socket.delegate = self
        return socket
    }()
    
    lazy var statusItem: NSStatusItem = {
        let statusItem = NSStatusBar.system.statusItem(withLength: 110)
        if let button = statusItem.button {
            label.frame = button.bounds
            button.addSubview(label)
        }
//        statusItem.button?.font = NSFont.systemFont(ofSize: 8)
//        statusItem.button?.title = ""
//        statusItem.button?.image = NSImage(named: "menubar-warning-white")
//        statusItem.button?.imagePosition = .imageLeading

        let menu = NSMenu(title: "menu")
        let item = NSMenuItem(title: "item", action: nil, keyEquivalent: "key1")
        menu.items.append(item)
        statusItem.menu = menu
        
        
        
//        let ctl = NSHostingController(rootView: BarLabel())
//
////        let v = NSHostingView(rootView: BarLabel())
//        statusItem.button?.addSubview(ctl.view)
        return statusItem
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
//        let contentView = ContentView()

        // Create the window and set the content view.
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//        window.isReleasedWhenClosed = false
//        window.center()
//        window.setFrameAutosaveName("Main Window")
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
        
        _ = statusItem
        
        socket.connect()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

