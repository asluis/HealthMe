//
//  firstScreen.swift
//  CMPE_131_UI
//
//  Created by Luis Alvarez on 3/22/21.
//

import SwiftUI

struct FirstScreen: View {
    @StateObject var viewManager: ViewManager
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    VStack{
                        Text("HealthMe")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                
                        Spacer()
                        Button(action: {
                            viewManager.currentView = .login
                        }, label: {
                            Text("Login")
                                .font(.title)
                                .bold()
                                .padding()
                                .frame(width: geo.size.width)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Capsule())
                        })
                        Button(action: {
                            // Action
                        }, label: {
                            Text("Register")
                                .font(.title)
                                .bold()
                                .padding()
                                .frame(width: geo.size.width)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(Capsule())
                        })
                        Spacer()
                    }
                }
            }
        }
    }
}

struct FirstScren_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen(viewManager: ViewManager())
    }
}
