//
//  Counter.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/18/21.
//

import Foundation
import Combine
import WatchConnectivity

final class Counter: ObservableObject {
    static let sharedModel = Counter()
    var session: WCSession
    let delegate: WCSessionDelegate
    let subject = PassthroughSubject<Int, Never>()
    var Todo1 = ""
    var Todo2 = ""
    var Todo3 = ""
    var Todo4 = ""
    var Todo5 = ""
    
    @Published private(set) var count: Int = 0
    
    init(session: WCSession = .default) {
        self.delegate = SessionDelegater(countSubject: subject)
        self.session = session
        self.session.delegate = self.delegate
        self.session.activate()
        
        subject
            .receive(on: DispatchQueue.main)
            .assign(to: &$count)
    }
    
    func update(){
        let userDefault = UserDefaults()
       
        userDefault.setValue(String(Todo1), forKey: "Todo1")
        userDefault.setValue(String(Todo2), forKey: "Todo2")
        userDefault.setValue(String(Todo3), forKey: "Todo3")
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
