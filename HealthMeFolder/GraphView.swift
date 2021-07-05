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
        GeometryReader{ geo in
            Bar(scalar: 0.5)
                .fill(Color.red)
                .frame(width: geo.size.width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
        
    }
}

// Horizontal Bar
struct Bar: Shape{
    let scalar:CGFloat // Scales size of rect given relationship with data
    
    // Starts drawing in top right of given rect/frame
    func path(in rect: CGRect) -> Path {
        let adjustedWidthX = scalar * rect.maxX
        
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: adjustedWidthX, y: rect.minY))// needs to be round
        path.addLine(to: CGPoint(x: adjustedWidthX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Needs to be round
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(user: User(weight: 10, height: 10, gender: "", heartRate: 10, time: 10, inCal: 10, outCal: 10, inCount: 10, wSum: 10, hrSum: 10, atSum: 10))
    }
}
