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
            ContentView(viewManager: viewManager, currUser: User(weight: 0, height: 0, gender: "", heartRate: 0, time: 0, inCal: 0, outCal: 0, inCount: 0, wSum: 0, hrSum: 0, atSum: 0))
        }
    }
}


//Connect Firebase
class Delegate : NSObject, UIApplicationDelegate, ObservableObject {    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
         
        return true
    }
}
