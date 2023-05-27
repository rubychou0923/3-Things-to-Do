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
    
    
    init(Todo1Subject: PassthroughSubject<String, Never>,
         Todo2Subject: PassthroughSubject<String, Never>,
         Todo3Subject: PassthroughSubject<String, Never>) {
        self.Todo1Subject = Todo1Subject
        self.Todo2Subject = Todo2Subject
        self.Todo3Subject = Todo3Subject
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
