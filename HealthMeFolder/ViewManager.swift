//
//  ViewManager.swift
//  HealthMe
//
//  Created by Luis Alvarez on 5/5/21.
//

import SwiftUI

class ViewManager:ObservableObject{
    @Published var currentView:Page = .main
    
    
}


enum Page{
    case main
    case intro
    case login
    case register
    case home
    case graphs
    case add
}
