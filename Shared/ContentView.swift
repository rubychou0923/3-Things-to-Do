//
//  ContentView.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/14/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var counter = Counter.share
 
    
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
                    HStack {
                        TextField("Todo1", text:$counter.Todo1)
                            .frame(width: metrics.size.width*0.8)
                        Button(action: counter.todo1done) {
                            Text("✓")
                        }
                    }
                    
                    HStack {
                        TextField("Todo2", text:$counter.Todo2)
                            .frame(width: metrics.size.width*0.8)
                        Button(action: counter.todo2done) {
                            Text("✓")
                        }
                    }
                    
                    HStack {
                        TextField("Todo3", text:$counter.Todo3)
                            .frame(width: metrics.size.width*0.8)
                        Button(action: counter.todo3done) {
                            Text("✓")
                        }
                    }
                    
                    HStack {
                        TextField("Todo4", text:$counter.Todo4)
                            .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                        Button(action: counter.todo4done) {
                            Text("✓")
                        }
                    }
                    HStack {
                        TextField("Todo5", text:$counter.Todo5)
                            .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                        Button(action: counter.todo5done) {
                            Text("✓")
                        }
                    }.padding(10)
                }
                    HStack {
                        Button(action: counter.update) {
                            Text("更新")
                        }.frame(width: metrics.size.width*0.7)
                        
                        Button(action: counter.reset) {
                            Text("重置")
                        }
                    }
              
                
#else
                Text("\(counter.cheerUpString)")
                    .font(.largeTitle)
                Text("\(counter.dateString)")
                    .font(.largeTitle)

                HStack {
                    TextField("Todo1", text:$counter.Todo1)
                        .frame(width: metrics.size.width*0.6, height: metrics.size.height*0.075)
                    Button(action: counter.todo1done) {
                        Text("✓")
                    }
                }
                
                HStack {
                    TextField("Todo2", text:$counter.Todo2)
                        .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                    Button(action: counter.todo2done) {
                        Text("✓")
                    }
                }
                
                HStack {
                    TextField("Todo3", text:$counter.Todo3)
                        .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                    Button(action: counter.todo3done) {
                        Text("✓")
                    }
                }
                HStack {
                    TextField("Todo4", text:$counter.Todo4)
                        .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                    Button(action: counter.todo4done) {
                        Text("✓")
                    }
                }
                HStack {
                    TextField("Todo5", text:$counter.Todo5)
                        .frame(width: metrics.size.width*0.6,height: metrics.size.height*0.075)
                    Button(action: counter.todo5done) {
                        Text("✓")
                    }
                }.padding(10)
                
                HStack {
                    Button(action: counter.update) {
                        Text("更新")
                    }
                    .font(.title)
                    .padding()
                    .background(Color(UIColor(red:55/255,green:112/255,blue:148/255,alpha: 1.00)))
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(width: metrics.size.width*0.6, height: metrics.size.height*0.1)
                    
                    
                    Button(action: counter.reset) {
                        Text("重置")
                    }
                    .font(.title)
                    .padding()
                    .background(Color(UIColor(red:42/255,green:112/255,blue:42/255,alpha: 1.00)))
                    .foregroundColor(.white)
                    .padding(10)
                    .frame(height: metrics.size.height*0.1)
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
