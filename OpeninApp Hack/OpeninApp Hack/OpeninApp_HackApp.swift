//
//  OpeninApp_HackApp.swift
//  OpeninApp Hack
//
//  Created by Rithvik Ronaldo on 12/04/24.
//

import SwiftUI

@main
struct OpeninApp_HackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContentViewModel.shared)
        }
    }
}
