//
//  ContentView.swift
//  HealthMe
//
//  Created by Luis Alvarez on 3/22/21.
//

import SwiftUI

struct ContentView: View {
    // Depending on val of viewManager we want to show the appropriate view
    @StateObject var viewManager:ViewManager
    var body: some View {
        //DataEntry_View()
        GeometryReader{geo in
            VStack{
                Spacer()
                // Views go here
                switch viewManager.currentView{
                case .home:
                    Text("HOME")
                case .graphs:
                    Text("GRAPHS")
                case .add:
                    DataEntryView(users: Users(), isRegistering: false) // TODO: Fix
                case .register:
                    Text("Register")
                case .login:
                    Text("Login")
                case .intro:
                    FirstScreen(viewManager: viewManager)
                }
                Spacer()
                HStack{
                    TabBarIcon(viewManager: viewManager, assignedPage: .home, width: geo.size.width / 5, height: geo.size.height / 28, systemIconName: "homekit", tabName: "Home")
                    
                    ZStack{
                        Circle()
                            .foregroundColor(viewManager.currentView == .add ? .white : .black)
                            .frame(width: geo.size.width / 7, height: geo.size.height / 7)
                            .shadow(radius: 4)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width / 7 - 6, height: geo.size.height / 7-6)
                            .foregroundColor(Color("AddColor"))
                    }
                    .padding(.horizontal)
                    .onTapGesture{
                        viewManager.currentView = .add
                    }
                    
                    TabBarIcon(viewManager: viewManager, assignedPage: .graphs, width: geo.size.width / 5, height: geo.size.height / 28, systemIconName: "waveform", tabName: "Graphs")
                }
                .frame(width: geo.size.width, height: geo.size.height / 8)
                .background(Color("TabAreaColor"))
                .shadow(radius: 2)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TabBarIcon: View {
    @StateObject var viewManager: ViewManager
    let assignedPage: Page
    let width, height:CGFloat
    let systemIconName, tabName:String
    var body: some View {
            VStack{
                Image(systemName: systemIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .padding(.top, 10)
                Text(tabName)
                    .font(.footnote)
                Spacer()
            }
            .padding()
            .onTapGesture{
                viewManager.currentView = assignedPage
            }
            .foregroundColor(viewManager.currentView == assignedPage ? .white : .black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewManager: ViewManager())
    }
}
