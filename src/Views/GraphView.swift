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
        Bar(scalar: 0.5, radius: 25)
        
    }
}






/**
 Creates a horizontal bar with its base being on the leftmost side of the view it's found in. The right side of the bar has rounded edges.
 */
struct Bar: View{
    
    let scalar: CGFloat
    let radius: CGFloat
    
    var body: some View{
        GeometryReader{ geo in
            MyBar(myScalar: 0.5, myRadius: 25)
                .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .background(MyBar(myScalar: 0.5, myRadius: 25).fill(Color.blue))
                .frame(width: geo.size.width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
    }
    
    struct MyBar: InsettableShape{
        var insetAmount:CGFloat = 0
        let myScalar:CGFloat
        let myRadius:CGFloat
        
        func inset(by amount: CGFloat) -> some InsettableShape {
            var shape = self
            shape.insetAmount += amount
            return shape
        }
        
        func path(in rect: CGRect) -> Path {
            let adjustedWidthX = myScalar * rect.maxX
            
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: adjustedWidthX - myRadius, y: rect.minY))
            path.addArc(center: CGPoint(x: adjustedWidthX - myRadius, y: rect.minY + myRadius), radius: myRadius - insetAmount, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: adjustedWidthX, y: rect.maxY - myRadius))
            path.addArc(center: CGPoint(x: adjustedWidthX - myRadius, y: rect.maxY - myRadius), radius: myRadius - insetAmount, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            return path
        }
    }

}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(user: User(weight: 10, height: 10, gender: "", heartRate: 10, time: 10, inCal: 10, outCal: 10, inCount: 10, wSum: 10, hrSum: 10, atSum: 10))
    }
}
