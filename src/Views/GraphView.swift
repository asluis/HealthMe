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
        GeometryReader{geo in
            ScrollView{
                VStack(alignment: .center){
                    GraphCard(title: "TITLE", currentVal: 20, avg: 30, height: 100, name: "Heart rate");
                }
                .frame(width: geo.size.width * 0.9)
                .background(Color("TileColor"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 1)
            }
        }
    }
}

struct GraphCard: View{
    let title:String
    let currentVal:CGFloat
    let avg:CGFloat
    let height:CGFloat
    let name:String
    
    var scalar:CGFloat {
        let total = currentVal + avg
        return currentVal / total
    }
    
    var body: some View{
        VStack{
            Text(title)
                .font(.title3)
                .bold()
            ZStack{
                Bar(scalar: scalar, radius: 25, height: height)
                    .padding(.bottom, height)
                Text("Recent \(name)")
                    .font(.headline)
            }
            
            ZStack{
                Bar(scalar: 1 - scalar, radius: 25, height: height)
                    .padding(.bottom, height)
                Text("Average \(name)")
                    .font(.headline)
            }
        }
    }
}



/**
 Creates a horizontal bar with its base being on the leftmost side of the view it's found in. The right side of the bar has rounded edges.
 */
struct Bar: View{
    
    let scalar: CGFloat
    let radius: CGFloat
    let height:CGFloat
    
    var body: some View{
        GeometryReader{ geo in
            MyBar(myScalar: scalar, myRadius: 25)
                //.stroke(Color.black, lineWidth: 3)
                .strokeBorder(Color.black, lineWidth: 4)
                .frame(width: geo.size.width, height: height)
                .background(MyBar(myScalar: scalar, myRadius: radius).fill(Color.blue))
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
            let adjustedWidthX = myScalar * rect.maxX - (rect.maxX * 0.1)
            
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + insetAmount))
            path.addLine(to: CGPoint(x: adjustedWidthX - myRadius, y: rect.minY + insetAmount))
            path.addArc(center: CGPoint(x: adjustedWidthX - myRadius, y: rect.minY + myRadius), radius: myRadius - insetAmount, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: adjustedWidthX - insetAmount, y: rect.maxY - myRadius))
            path.addArc(center: CGPoint(x: adjustedWidthX - myRadius, y: rect.maxY - myRadius), radius: myRadius - insetAmount, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - insetAmount))
            return path
        }
    }

}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(user: User(weight: 10, height: 10, gender: "", heartRate: 10, time: 10, inCal: 10, outCal: 10, inCount: 10, wSum: 10, hrSum: 10, atSum: 10))
    }
}
