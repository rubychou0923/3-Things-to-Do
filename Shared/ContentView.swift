//
//  ContentView.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/14/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject var counter = Counter.share
    @State private var presentAlert = true
   
    let done_visiable=0.5
    
    var labelStyle: some LabelStyle {
        #if os(watchOS)
        return IconOnlyLabelStyle()
        #else
        return DefaultLabelStyle()
        #endif
    }
    
    
    var body: some View {
        /*
        VStack {
            Text("\(counter.count)")
                .font(.largeTitle)
            
            HStack {
                Button(action: counter.decrement) {
                    Label("Decrement", systemImage: "minus.circle")
                }
                .padding()
                
                Button(action: counter.increment) {
                    Label("Increment", systemImage: "plus.circle.fill")
                }
                .padding()
            }
            .font(.headline)
            .labelStyle(labelStyle)
        }
         */
        GeometryReader { metrics in
            VStack {
                
#if !os(iOS)
                ScrollView(.vertical){
                    if !counter.isTodo1Hidden {
                        HStack {
                            TextField("Todo1", text:$counter.Todo1)
                                .frame(width: metrics.size.width*0.8)
                                .opacity(counter.isTodo1Hidden ? 0.3 : 1)
                            Button(action: counter.todo1done) {
                                Text("✓");
                            }
                        }
                    }
                    
                    if !counter.isTodo2Hidden {
                        HStack {
                            TextField("Todo2", text:$counter.Todo2)
                                .frame(width: metrics.size.width*0.8)
                                .opacity(counter.isTodo2Hidden ? 0.3 : 1)
                            Button(action: counter.todo2done) {
                                Text("✓")
                            }
                        }
                    }
                    
                    if !counter.isTodo3Hidden {
                        HStack {
                            TextField("Todo3", text:$counter.Todo3)
                                .frame(width: metrics.size.width*0.8)
                                .opacity(counter.isTodo3Hidden ? 0.3 : 1)
                            Button(action: counter.todo3done) {
                                Text("✓")
                            }
                        }
                    }
                    
                    if !counter.isTodo4Hidden {
                        HStack {
                            TextField("Todo4", text:$counter.Todo4)
                                .frame(width: metrics.size.width*0.8)
                                .opacity(counter.isTodo4Hidden ? 0.3 : 1)
                            Button(action: counter.todo4done) {
                                Text("✓")
                            }
                        }
                    }
                    
                    if !counter.isTodo5Hidden {
                        HStack {
                            TextField("Todo5", text:$counter.Todo5)
                                .frame(width: metrics.size.width*0.8)
                                .opacity(counter.isTodo5Hidden ? 0.3 : 1)
                            Button(action: counter.todo5done) {
                                Text("✓")
                            }
                        }
                    }
                    
                    HStack {
                        Button(action: counter.update) {
                            Text("Update")
                        }.frame(width: metrics.size.width*0.5)
                        
                        Button(action: counter.display_reset) {
                            Label("", systemImage: "eye.fill")
                        }
                        
                        
                        Button(action: counter.reset) {
                            Label("", systemImage: "arrow.counterclockwise")
                        }
                    }

                   /* Button("Request permission")
                    {
                         UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                         if success{
                             print("All set")
                         } else if let error = error {
                             print(error.localizedDescription)
                            }
                         }
                    }*/
                    Button(action: counter.register_nofification) {
                        Text("Schedule Notification")
                    }/*
                    Button("Schedule Notification")
                    {

                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                        if success{
                            print("All set")
                        } else if let error = error {
                            print(error.localizedDescription)
                           }
                        }

                        let content = UNMutableNotificationContent()
                        content.title = "Drink some milk!"
                    content.subtitle = "you have 10 sec"
                    content.sound = .default
                    content.categoryIdentifier = "myCategory"
                    let category = UNNotificationCategory(identifier: "myCategory", actions: [], intentIdentifiers: [], options: [])
                    UNUserNotificationCenter.current().setNotificationCategories([category])
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
                    let request = UNNotificationRequest(identifier: "milk", content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request) { (error) in
                      if let error = error{
                    print(error.localizedDescription)
                    }else{
                    print("scheduled successfully")
                    }
                    }
                    }*/
                }
                
                
#else
                Text("\(counter.cheerUpString)")
                    .font(.largeTitle)
                Text("\(counter.dateString)")
                    .font(.largeTitle)

                //if !counter.isTodo1Hidden {
                    HStack {
                        TextField("Todo1", text:$counter.Todo1)
                            .frame(width: metrics.size.width*0.6, height: metrics.size.height*0.075)
                            .opacity(counter.isTodo1Hidden ? done_visiable : 1)
                        Button(action: counter.todo1done) {
                            Text("✓")
                        }
                    }
                //}
                
                //if !counter.isTodo2Hidden {
                    HStack {
                        TextField("Todo2", text:$counter.Todo2)
                            .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                            .opacity(counter.isTodo2Hidden ? done_visiable : 1)
                        Button(action: counter.todo2done) {
                            Text("✓")
                        }
                    }
                //}
                
                //if !counter.isTodo3Hidden {
                    HStack {
                        TextField("Todo3", text:$counter.Todo3)
                            .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                            .opacity(counter.isTodo3Hidden ? done_visiable : 1)
                        Button(action: counter.todo3done) {
                            Text("✓")
                        }
                    }
                //}
                
               // if !counter.isTodo4Hidden {
                    HStack {
                        TextField("Todo4", text:$counter.Todo4)
                            .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                            .opacity(counter.isTodo4Hidden ? done_visiable : 1)
                        Button(action: counter.todo4done) {
                            Text("✓")
                        }
                    }
               // }
                
               // if !counter.isTodo5Hidden {
                    HStack {
                        TextField("Todo5", text:$counter.Todo5)
                            .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                            .opacity(counter.isTodo5Hidden ? done_visiable : 1)
                        Button(action: counter.todo5done) {
                            Text("✓")
                        }
                    }
               // }
                
                HStack {
                    Button(action: counter.update) {
                        Text("Update")
                    }//.alert("更新", isPresented: $presentAlert, actions: { })
                    .font(.title)
                    .padding()
                    .background(Color(UIColor(red:55/255,green:112/255,blue:148/255,alpha: 1.00)))
                    .foregroundColor(.white)
                    .frame(width: metrics.size.width*0.4, height: metrics.size.height*0.1)
 
                    Button(action: counter.display_reset) {
                        Text("Show")
                    }
                    .font(.title)
                    .padding()
                    .background(Color(UIColor(red:42/255,green:112/255,blue:42/255,alpha: 1.00)))
                    .foregroundColor(.white)
                    .frame(height: metrics.size.height*0.1)
                    
                    Button(action: counter.reset) {
                        Text("Reset")
                    }
                    .font(.title)
                    .padding()
                    .background(Color(UIColor(red:42/255,green:112/255,blue:42/255,alpha: 1.00)))
                    .foregroundColor(.white)
                    .frame(height: metrics.size.height*0.1)
                }

                /*
                Button("Request permission")
                {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                if success{
                print("All set")
                } else if let error = error {
                print(error.localizedDescription)
                }
                }
                }
                 */
                Button("Schedule Notification 10")
                {

                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
                    if success{
                    print("All set")
                    } else if let error = error {
                    print(error.localizedDescription)
                    }
                    }
                let content = UNMutableNotificationContent()
                content.title = "Drink some milk!"
                content.subtitle = "you have 10 sec"
                content.sound = .default
                content.categoryIdentifier = "myCategory"
                let category = UNNotificationCategory(identifier: "myCategory", actions: [], intentIdentifiers: [], options: [])
                UNUserNotificationCenter.current().setNotificationCategories([category])
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                let request = UNNotificationRequest(identifier: "milk", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error{
                print(error.localizedDescription)
                }else{
                print("scheduled successfully")
                }
                }
                }
/*
                Text("\(counter.Todo1)")
                    .font(.largeTitle)
                Text("\(counter.Todo2)")
                    .font(.largeTitle)
                Text("\(counter.Todo3)")
                    .font(.largeTitle)
 */
#endif
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

