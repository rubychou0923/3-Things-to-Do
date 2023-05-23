//
//  ContentView.swift
//  WatchConnectivityPrototype
//
//  Created by Chris Gaafary on 4/14/21.
//

import SwiftUI

class Model {
    static let sharedModel = Model()
    var Todo1: String!
    var Todo2: String!
    var Todo3: String!
}


struct ContentView: View {
    @StateObject var counter = Counter()
    @State var Todo1 = ""
    @State var Todo2 = ""
    @State var Todo3 = ""
    @State var Todo4 = ""
    @State var Todo5 = ""
    
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
            TextField("Todo1", text:$counter.Todo2)
            TextField("Todo1", text:$counter.Todo3)
            Button(action: counter.update) {
                Label("done", systemImage: "plus.circle.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
