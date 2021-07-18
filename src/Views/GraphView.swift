//
//  GraphView.swift
//  HealthMe
//
//  Created by Luis Alvarez on 6/20/21.
//

import SwiftUI

struct GraphView: View {
    @StateObject var user:User
    
    var body: some View {
        let activityTime = CGFloat(user.activityTime)
        let weight = CGFloat(user.weight)
        let heartRate = CGFloat(user.heartRate)
        
        let inputCount = CGFloat(user.inputCount)
        
        let activityAvg = CGFloat(user.activityTimeSum) / inputCount
        let weightAvg = CGFloat(user.weightSum) / inputCount
        let heartRateAvg = CGFloat(user.heartRateSum) / inputCount
        
        
        GeometryReader{geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("GraphViewBackground"), .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: .center){
                    Text("Compare your current stats to your average stats!")
                        .font(.title)
                    ScrollView{
                        GraphCard(title: "Activity Time (min)", currentVal: activityTime, avg: activityAvg, height: 100, darkBackground: true, barColors: Color("AddColor"))
                            .frame(width: geo.size.width * 0.9)
                            .background(Color("CardBackground").shadow(radius: 10))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        Spacer(minLength: 35)
                        GraphCard(title: "Heart Rate (beats/min)", currentVal: heartRate, avg: heartRateAvg, height: 100, darkBackground: true, barColors: Color("HeartBar"))
                            .frame(width: geo.size.width * 0.9)
                            .background(Color("CardBackground"))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        Spacer(minLength: 35)
                        GraphCard(title: "Weight (lbs)", currentVal: weight, avg: weightAvg, height: 100, darkBackground: true, barColors: Color("WeightBar"))
                            .frame(width: geo.size.width * 0.9)
                            .background(Color("CardBackground"))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
            }
        }
    }
}

struct GraphCard: View{
    let title:String
    let currentVal:CGFloat
    let avg:CGFloat
    let height:CGFloat
    let darkBackground:Bool
    let barColors:Color
    
    var scalar:CGFloat {
        let total = currentVal + avg
        return currentVal / total
    }
    
    var body: some View{
        VStack{
            Text(title)
                .font(.title3)
                .bold()
                .padding(.top)
                .foregroundColor(darkBackground ? .white : .black)
            ZStack{
                Bar(scalar: scalar, radius: 25, height: height, barColor: barColors)
                    .padding(.bottom, height)
                Text("Recent: \(currentVal, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(darkBackground ? .white : .black)
            }
            
            ZStack{
                Bar(scalar: 1 - scalar, radius: 25, height: height, barColor: barColors)
                    .padding(.bottom, height)
                Text("Average: \(avg, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(darkBackground ? .white : .black)
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
    let barColor:Color
    
    var body: some View{
        GeometryReader{ geo in
            MyBar(myScalar: scalar, myRadius: 25)
                //.stroke(Color.black, lineWidth: 3)
                .strokeBorder(Color.black, lineWidth: 4)
                .frame(width: geo.size.width, height: height)
                .background(MyBar(myScalar: scalar, myRadius: radius).fill(barColor))
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
        GraphView(user: User(weight: 120, height: 10, gender: "", heartRate: 85, time: 80, inCal: 10, outCal: 10, inCount: 2, wSum: 230, hrSum: 180, atSum: 200))
    }
}
