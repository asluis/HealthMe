//
//  CMPE_131_UIApp.swift
//  CMPE_131_UI
//
//  Created by Luis Alvarez on 3/22/21.
//

import SwiftUI
import Firebase

@main
struct HealthMeApp: App {
    @StateObject var viewManager:ViewManager = ViewManager()

    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView(viewManager: viewManager)
        }
    }
}


//Connect Firebase
class Delegate : NSObject, UIApplicationDelegate, ObservableObject {
    @Published var signedIn: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
         
        return true
    }
}
