//
//  __Things_ToDoApp.swift
//  3 Things ToDo WatchKit Extension
//
//  Created by RubyChou on 2023/5/20.
//

import SwiftUI

@main
struct __Things_ToDoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
