//
//  Home.swift
//  HealthMe
//
//  Created by Luis Alvarez on 5/10/21.
//

import SwiftUI

struct Home: View {
    
    @StateObject var user:User
    var bmi:Double {
        let height:Double = (Double)(user.height)
        return ((user.weight / height) / height) * 703.0
    }
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    Text("Hello \(user.name)!")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    ScrollView{
                        HStack(alignment: .center){
                            VStack{
                                Text("Vitals")
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                Image(systemName: "waveform.path.ecg")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.red)
                            }
                            Text("Heartrate: \(user.heartRate) bpm")
                                .font(.headline)
                                .padding()
                            Text("BMI: \(bmi, specifier: "%.1f")")
                                .font(.headline)
                                .padding()
                        }
                        .frame(width: geo.size.width * 0.9)
                        .background(Color("TileColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(radius: 1)
                        Spacer()
                        HStack(alignment: .center){
                            VStack{
                                Text("Health Stats")
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                Image(systemName: "heart.text.square")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.black)
                            }
                            VStack{
                                Text("Weight: \(user.weight, specifier: "%.1f") lbs")
                                    .font(.headline)
                                Text("Height: \(user.height) inches")
                                    .font(.headline)
                                    .padding()
                            }
                            Text("Gender: \(user.gender)")
                                .font(.headline)
                        }
                        .frame(width: geo.size.width * 0.9)
                        .background(Color("TileColor1"))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(radius: 1)
                        Spacer()
                        HStack(alignment: .center){
                            VStack{
                                Text("Exercise")
                                    .font(.headline)
                                    .bold()
                                    .padding()
                                Image(systemName: "person.2.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color("PersonColor"))
                            }
                            Text("Activity time: \(user.activityTime) min")
                                .font(.headline)
                                .padding()
                            Text("Total activity time: \(user.activityTimeSum) min")
                                .font(.headline)
                                .padding()
                        }
                        .frame(width: geo.size.width * 0.9)
                        .background(Color("Background1"))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(radius: 1)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(user: User(weight: 10, height: 10, gender: "male", heartRate: 0, time: 0, inCal: 0, outCal: 0, inCount: 0, wSum: 0, hrSum: 0, atSum: 0))
    }
}
