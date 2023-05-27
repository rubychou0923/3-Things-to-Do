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
                    Button(action: counter.update) {
                        Text("更新")
                    }.frame(width: metrics.size.width*0.7)
                    
                    Button(action: counter.reset) {
                        Text("重置")
                    }
                }
#if os(iOS)
                Text("\(counter.Todo1)")
                    .font(.largeTitle)
                Text("\(counter.Todo2)")
                    .font(.largeTitle)
                Text("\(counter.Todo3)")
                    .font(.largeTitle)
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
