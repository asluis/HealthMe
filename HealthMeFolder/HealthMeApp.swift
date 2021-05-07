//
//  CMPE_131_UIApp.swift
//  CMPE_131_UI
//
//  Created by Luis Alvarez on 3/22/21.
//

import SwiftUI

@main
struct HealthMeApp: App {
    @StateObject var viewManager:ViewManager = ViewManager()

    var body: some Scene {
        WindowGroup {
            ContentView(viewManager: viewManager)
        }
    }
}
