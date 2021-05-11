//
//  Home.swift
//  HealthMe
//
//  Created by Luis Alvarez on 5/10/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var user:User
    
    var body: some View {
        Text("Hello \(user.name)")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(user: User(weight: 0, height: 0, gender: "", heartRate: 0, time: 0, inCal: 0, outCal: 0, inCount: 0, wSum: 0, hrSum: 0, atSum: 0))
    }
}
