//
//  GraphView.swift
//  HealthMe
//
//  Created by Luis Alvarez on 6/20/21.
//

import SwiftUI

struct GraphView: View {
    let user:User
    
    var body: some View {
        Text("Hello, \(user.name)")
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(user: User(weight: 10, height: 10, gender: "", heartRate: 10, time: 10, inCal: 10, outCal: 10, inCount: 10, wSum: 10, hrSum: 10, atSum: 10))
    }
}
