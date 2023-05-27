//
//  Counter.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/18/21.
//

import Foundation
import Combine
import WatchConnectivity
import ClockKit
import SwiftUI
import os

final class Counter: ObservableObject {
    static let share = Counter()
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Int, Never>()
    let Todo1Subject = PassthroughSubject<String, Never>()
    let Todo2Subject = PassthroughSubject<String, Never>()
    let Todo3Subject = PassthroughSubject<String, Never>()
    //var Todo1 = ""
    //var Todo2 = ""
    //var Todo3 = ""
    var Todo4 = ""
    var Todo5 = ""
    
    @Published private(set) var count: Int = 0
    @Published var Todo1: String = ""
    @Published var Todo2: String = ""
    @Published var Todo3: String = ""
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(Todo1Subject: Todo1Subject,
                                         Todo2Subject: Todo2Subject,
                                         Todo3Subject: Todo3Subject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        Todo1Subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$Todo1)
        Todo2Subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$Todo2)
        Todo3Subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$Todo3)
    }
    
    func reset(){
        Counter.share.Todo1=""
        Counter.share.Todo2=""
        Counter.share.Todo3=""
        
        #if !os(iOS)
         let server=CLKComplicationServer.sharedInstance()
         for complication in server.activeComplications ?? [] {
             server.reloadTimeline ( for : complication)
         }
         #endif
    }
    
    func update(){
        //let userDefault = UserDefaults()
       
        //userDefault.setValue(String(Todo1), forKey: "Todo1")
        //userDefault.setValue(String(Todo2), forKey: "Todo2")
        //userDefault.setValue(String(Todo3), forKey: "Todo3")
        
        Counter.share.Todo1=Todo1
        Counter.share.Todo2=Todo2
        Counter.share.Todo3=Todo3
        
       #if !os(iOS)
        let server=CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline ( for : complication)
        }
        #endif
        
        session.sendMessage(["Todo1": Todo1, "Todo2":Todo2, "Todo3":Todo3], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
        print("after session.sendMessage")
        /*
        let complicationServer = CLKComplicationServer.sharedInstance()

        if let activeComplications = complicationServer.activeComplications {
          for complication in activeComplications {
              // Be selective on what you actually need to reload
            complicationServer.reloadTimeline(for: complication)
          }
        }
        */
    }
    
    func todo1done()
    {
        print("todo1done")
        Counter.share.Todo1+="完成"
    }
    
    func todo2done()
    {
        print("todo2done")
        Counter.share.Todo2+="完成"
    }
    
    func todo3done()
    {
        print("todo3done")
        Counter.share.Todo3+="完成"
    }
    
    
    func increment() {
        count += 1
        
        let userInfo: [String: [Int]] = [
          "count": [count]
        ]
        
        WCSession.default.transferUserInfo(userInfo)
        let userDefault = UserDefaults()
       
        userDefault.setValue(String(count), forKey: "count")
        
        session.sendMessage(["count": count], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
    
    func decrement() {
        count -= 1
        let userDefault = UserDefaults()
       
        userDefault.setValue(String(count), forKey: "count")
        let userInfo: [String: [Int]] = [
          "count": [count]
        ]
        
        //WidgetCenter.shared.reloadAllTimelines()
        WCSession.default.transferUserInfo(userInfo)
        
        session.sendMessage(["count": count], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
    }
}
