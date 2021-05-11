//
//  ViewManager.swift
//  HealthMe
//
//  Created by Luis Alvarez on 5/5/21.
//

import SwiftUI

class ViewManager:ObservableObject{
    @Published var currentView:Page = .main
    
    @Published var uid = ""
    @Published var user = User(weight: 0.0, height: 10, gender: "", heartRate: 10, time: 10, inCal: 10, outCal: 10, inCount: 10, wSum: 10, hrSum: 10, atSum: 1)
}


enum Page{
    case newAdd
    case main
    case intro
    case login
    case register
    case home
    case graphs
    case add
}
