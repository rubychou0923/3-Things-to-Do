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

class todoData : ObservableObject {
    var Todo: String = ""
    var isTodo1Finish = false
}

final class Counter: ObservableObject {
    static let share = Counter()
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Int, Never>()
    let Todo1Subject = PassthroughSubject<String, Never>()
    let Todo2Subject = PassthroughSubject<String, Never>()
    let Todo3Subject = PassthroughSubject<String, Never>()
    let Todo4Subject = PassthroughSubject<String, Never>()
    let Todo5Subject = PassthroughSubject<String, Never>()
    
    let Todo1HiddenSubject = PassthroughSubject<Bool, Never>()
    let Todo2HiddenSubject = PassthroughSubject<Bool, Never>()
    let Todo3HiddenSubject = PassthroughSubject<Bool, Never>()
    let Todo4HiddenSubject = PassthroughSubject<Bool, Never>()
    let Todo5HiddenSubject = PassthroughSubject<Bool, Never>()

    
    @Published var isTodo1Hidden = false
    @Published var isTodo2Hidden = false
    @Published var isTodo3Hidden = false
    @Published var isTodo4Hidden = false
    @Published var isTodo5Hidden = false
    //var Todo1 = ""
    //var Todo2 = ""
    //var Todo3 = ""

    let cheerUpString = "感恩 謙卑 正向"
    
    @Published private(set) var count: Int = 0
    @Published var Todo1: String = ""
    @Published var Todo2: String = ""
    @Published var Todo3: String = ""
    @Published var Todo4: String = ""
    @Published var Todo5: String = ""
    
    @Published var dateString: String = ""
    
    func getWeekday() -> String {
        let calendar = Calendar.current
        let todayDate = Date()
        let weekday = calendar.component(.weekday, from: todayDate)
        let weekdayInt = Int(weekday)
        
        switch(weekdayInt){
        case 1:
            return "日"
        case 2:
            return "一"
        case 3:
            return "二"
        case 4:
            return "三"
        case 5:
            return "四"
        case 6:
            return "五"
        case 7:
            return "六"
        default:
            return ""
        }
        
       // return ""
    }
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(Todo1Subject: Todo1Subject,
                                         Todo2Subject: Todo2Subject,
                                         Todo3Subject: Todo3Subject,
                                         Todo4Subject: Todo4Subject,
                                         Todo5Subject: Todo5Subject,
                                         Todo1HiddenSubject: Todo1HiddenSubject,
                                         Todo2HiddenSubject: Todo2HiddenSubject,
                                         Todo3HiddenSubject: Todo3HiddenSubject,
                                         Todo4HiddenSubject: Todo4HiddenSubject,
                                         Todo5HiddenSubject: Todo5HiddenSubject
        )
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
        Todo4Subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$Todo4)
        Todo5Subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$Todo5)
        
        Todo1HiddenSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$isTodo1Hidden)
        Todo2HiddenSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$isTodo2Hidden)
        Todo3HiddenSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$isTodo3Hidden)
        Todo4HiddenSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$isTodo4Hidden)
        Todo5HiddenSubject
            .receive(on: DispatchQueue.main)
            .assign(to: &$isTodo5Hidden)
        
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let todayDate = Date()
        let weekday = calendar.component(.weekday, from: todayDate)
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.dateString = dateFormatter.string(from: todayDate)
        let weekdayString = "(" + getWeekday() + ")"
        self.dateString = self.dateString + weekdayString
    }
    
    func display_reset(){
        Counter.share.isTodo1Hidden=false
        Counter.share.isTodo2Hidden=false
        Counter.share.isTodo3Hidden=false
        Counter.share.isTodo4Hidden=false
        Counter.share.isTodo5Hidden=false
    }
    
    func reset(){
        Counter.share.Todo1=""
        Counter.share.Todo2=""
        Counter.share.Todo3=""
        Counter.share.Todo4=""
        Counter.share.Todo5=""
        Counter.share.isTodo1Hidden=false
        Counter.share.isTodo2Hidden=false
        Counter.share.isTodo3Hidden=false
        Counter.share.isTodo4Hidden=false
        Counter.share.isTodo5Hidden=false
        
        #if !os(iOS)
         let server=CLKComplicationServer.sharedInstance()
         for complication in server.activeComplications ?? [] {
             server.reloadTimeline ( for : complication)
         }
         #endif
        
        session.sendMessage(["Todo1": Todo1, "Todo2":Todo2, "Todo3":Todo3,"Todo4":Todo4,"Todo5":Todo5,
                             "isTodo1Hidden": isTodo1Hidden,
                             "isTodo2Hidden": isTodo2Hidden,
                             "isTodo3Hidden": isTodo3Hidden,
                             "isTodo4Hidden": isTodo4Hidden,
                             "isTodo5Hidden": isTodo5Hidden,
                            ], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
        
        print("reset session.sendMessage")
    }
    
    func update(){
        //let userDefault = UserDefaults()
       
        //userDefault.setValue(String(Todo1), forKey: "Todo1")
        //userDefault.setValue(String(Todo2), forKey: "Todo2")
        //userDefault.setValue(String(Todo3), forKey: "Todo3")
        
        Counter.share.Todo1=Todo1
        Counter.share.Todo2=Todo2
        Counter.share.Todo3=Todo3
        Counter.share.Todo4=Todo4
        Counter.share.Todo5=Todo5
        
       #if !os(iOS)
        let server=CLKComplicationServer.sharedInstance()
        for complication in server.activeComplications ?? [] {
            server.reloadTimeline ( for : complication)
        }
        #endif
        
        session.sendMessage(["Todo1": Todo1, "Todo2":Todo2, "Todo3":Todo3,"Todo4":Todo4,"Todo5":Todo5,
                             "isTodo1Hidden": isTodo1Hidden,
                             "isTodo2Hidden": isTodo2Hidden,
                             "isTodo3Hidden": isTodo3Hidden,
                             "isTodo4Hidden": isTodo4Hidden,
                             "isTodo5Hidden": isTodo5Hidden,
                            ], replyHandler: nil) { error in
            print(error.localizedDescription)
        }
        print("update session.sendMessage")
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
      //  Counter.share.Todo1+="完成"
        Counter.share.isTodo1Hidden.toggle()
        print(Counter.share.isTodo1Hidden)
    }
    
    func todo2done()
    {
        print("todo2done")
        Counter.share.isTodo2Hidden.toggle()
       // Counter.share.Todo2+="完成"
    }
    
    func todo3done()
    {
        print("todo3done")
        Counter.share.isTodo3Hidden.toggle()
        //Counter.share.Todo3+="完成"
    }
    
    func todo4done()
    {
        print("todo4done")
        Counter.share.isTodo4Hidden.toggle()
     //   Counter.share.Todo4+="完成"
    }
    
    func todo5done()
    {
        print("todo5done")
        Counter.share.isTodo5Hidden.toggle()
      //  Counter.share.Todo5+="完成"
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
