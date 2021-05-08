//
//  ContentView.swift
//  HealthMe
//
//

import SwiftUI

struct ContentView: View {
    // Depending on val of viewManager we want to show the appropriate view
    @StateObject var viewManager:ViewManager
    var body: some View {
        GeometryReader{geo in
            VStack{
                Spacer()
                // Views go here
                switch viewManager.currentView{
                case .main:
                    FirstScreen(viewManager: viewManager)
                case .home:
                    Text("HOME")
                case .graphs:
                    Text("GRAPHS")
                case .add:
                    DataEntryView(users: Users(), isRegistering: false) // TODO: Fix
                case .newAdd:
                    DataEntryView(users: Users(), isRegistering: true)
                    // TODO: Fix
                case .register:
                    RegistrationView(viewManager: viewManager)
                case .login:
                    LoginView(viewManager: viewManager)
                case .intro:
                    FirstScreen(viewManager: viewManager)
                }
                Spacer()
                if viewManager.currentView == .home || viewManager.currentView == .graphs || viewManager.currentView == .add{
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
