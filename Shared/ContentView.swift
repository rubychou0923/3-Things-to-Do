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
        VStack {
            TextField("Todo1", text:$counter.Todo1)
            TextField("Todo2", text:$counter.Todo2)
            TextField("Todo3", text:$counter.Todo3)
            Button(action: counter.update) {
                Label("done", systemImage: "plus.circle.fill")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
