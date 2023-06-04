//
//  SessionDelegator.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/15/21.
//

import Combine
import WatchConnectivity
import ClockKit



class SessionDelegater: NSObject, WCSessionDelegate {
   // let countSubject: PassthroughSubject<Int, Never>
    let Todo1Subject: PassthroughSubject<String, Never>
    let Todo2Subject: PassthroughSubject<String, Never>
    let Todo3Subject: PassthroughSubject<String, Never>
    let Todo4Subject: PassthroughSubject<String, Never>
    let Todo5Subject: PassthroughSubject<String, Never>
    
    var Todo1HiddenSubject = PassthroughSubject<Bool, Never>()
    var Todo2HiddenSubject = PassthroughSubject<Bool, Never>()
    var Todo3HiddenSubject = PassthroughSubject<Bool, Never>()
    var Todo4HiddenSubject = PassthroughSubject<Bool, Never>()
    var Todo5HiddenSubject = PassthroughSubject<Bool, Never>()
    
    init(Todo1Subject: PassthroughSubject<String, Never>,
         Todo2Subject: PassthroughSubject<String, Never>,
         Todo3Subject: PassthroughSubject<String, Never>,
         Todo4Subject: PassthroughSubject<String, Never>,
         Todo5Subject: PassthroughSubject<String, Never>,
         Todo1HiddenSubject :PassthroughSubject<Bool, Never>,
         Todo2HiddenSubject :PassthroughSubject<Bool, Never>,
         Todo3HiddenSubject :PassthroughSubject<Bool, Never>,
         Todo4HiddenSubject :PassthroughSubject<Bool, Never>,
         Todo5HiddenSubject :PassthroughSubject<Bool, Never>
    ) {
        self.Todo1Subject = Todo1Subject
        self.Todo2Subject = Todo2Subject
        self.Todo3Subject = Todo3Subject
        self.Todo4Subject = Todo4Subject
        self.Todo5Subject = Todo5Subject
        
        self.Todo1HiddenSubject = Todo1HiddenSubject
        self.Todo2HiddenSubject = Todo2HiddenSubject
        self.Todo3HiddenSubject = Todo3HiddenSubject
        self.Todo4HiddenSubject = Todo4HiddenSubject
        self.Todo5HiddenSubject = Todo5HiddenSubject
        
        super.init()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Protocol comformance only
        // Not needed for this demo
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async {
            if let Todo1 = message["Todo1"] as? String{
                self.Todo1Subject.send(Todo1)
                Counter.share.Todo1 = Todo1
                print("Todo1")
                print(Counter.share.Todo1)
            }
            if let Todo2 = message["Todo2"] as? String{
                self.Todo2Subject.send(Todo2)
                Counter.share.Todo2 = Todo2
                print("Todo2")
                print(Counter.share.Todo2)
            }
            if let Todo3 = message["Todo3"] as? String{
                self.Todo3Subject.send(Todo3)
                Counter.share.Todo2 = Todo3
                print("Todo3")
                print(Counter.share.Todo3)
            }
            if let Todo4 = message["Todo4"] as? String{
                self.Todo4Subject.send(Todo4)
                Counter.share.Todo4 = Todo4
                print("Todo4")
                print(Counter.share.Todo4)
            }
            if let Todo5 = message["Todo5"] as? String{
                self.Todo5Subject.send(Todo5)
                Counter.share.Todo5 = Todo5
                print("Todo5")
                print(Counter.share.Todo5)
            }
            if let isTodo1Hidden = message["isTodo1Hidden"] as? Bool{
                self.Todo1HiddenSubject.send(isTodo1Hidden)
                Counter.share.isTodo1Hidden = isTodo1Hidden
                print("isTodo1Hidden")
                print(Counter.share.isTodo1Hidden)
            }
            if let isTodo2Hidden = message["isTodo2Hidden"] as? Bool{
                self.Todo2HiddenSubject.send(isTodo2Hidden)
                Counter.share.isTodo2Hidden = isTodo2Hidden
                print("isTodo2Hidden")
                print(Counter.share.isTodo2Hidden)
            }
            
            if let isTodo3Hidden = message["isTodo3Hidden"] as? Bool{
                self.Todo3HiddenSubject.send(isTodo3Hidden)
                Counter.share.isTodo3Hidden = isTodo3Hidden
                print("isTodo3Hidden")
                print(Counter.share.isTodo1Hidden)
            }
            
            if let isTodo4Hidden = message["isTodo4Hidden"] as? Bool{
                self.Todo4HiddenSubject.send(isTodo4Hidden)
                Counter.share.isTodo4Hidden = isTodo4Hidden
                print("isTodo4Hidden")
                print(Counter.share.isTodo4Hidden)
            }
            
            if let isTodo5Hidden = message["isTodo5Hidden"] as? Bool{
                self.Todo5HiddenSubject.send(isTodo5Hidden)
                Counter.share.isTodo5Hidden = isTodo5Hidden
                print("isTodo5Hidden")
                print(Counter.share.isTodo5Hidden)
            }
            
            #if !os(iOS)
             let server=CLKComplicationServer.sharedInstance()
             for complication in server.activeComplications ?? [] {
                 server.reloadTimeline ( for : complication)
             }
             #endif
        }
        
    }

    // iOS Protocol comformance
    // Not needed for this demo otherwise
    #if os(iOS)
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
    
}
