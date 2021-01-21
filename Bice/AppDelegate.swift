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

    lazy var socket: WebSocket = {
        let url = URL(string: "wss://fstream.binance.com/ws/btcusdt@ticker")!
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
                    let c = json["c"] as! String
                    print("Received text: \(c)")
                    self?.statusItem.button?.title = "BTC/USDT: " + c
                }
                
                
//                print("Received text: \(string)")
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
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
        statusItem.button?.font = NSFont.systemFont(ofSize: 11)
        let menu = NSMenu(title: "menu")
        let item = NSMenuItem(title: "item", action: nil, keyEquivalent: "key1")
        menu.items.append(item)
        statusItem.menu = menu
        
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

