//
//  LoginView.swift
//  HealthMe
//
//  Created by Luis Alvarez on 5/7/21.
//

import SwiftUI
import Firebase


struct LoginView: View {
    @StateObject var viewManager:ViewManager
    
    @State private var email = ""
    @State private var password = ""
    
    @State var isShowingAlert = false
    @State var alertMsg = ""
    @State var alertTitle = ""
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("Background1"), Color("ButtonColor1")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    

                    Text("Sign In")
                        .font(.largeTitle)
                        
                    HStack{
                        Image(systemName: "envelope")

                        

                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                    }
                 //   .frame(width: geo.size.width)
                    
                    HStack{
                        Image(systemName: "key")
                        SecureField("Password", text: $password)
                            .autocapitalization(.none)
                    }
                    
                    
                    Button(action:{
                        if email == "" || password == "" {
                            alertTitle = "Error Logging in"
                            alertMsg = "Please fill out BOTH email and password"
                            isShowingAlert = true
                        }else{
                        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                                if error != nil {
                                    alertTitle = "Error Loggin in"
                                    alertMsg = error?.localizedDescription ?? "Error    loggin in"
                                
                                    isShowingAlert = true
                                }else{
                                    // Successful login
                                    email = ""
                                    password = ""
                                    
                                   print("SUCCESS LOGGING IN")
                                
                                }
                            }
                        }
                    }){
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: geo.size.width / 3, height: geo.size.height / 10)
                            .background(Color("AddColor"))
                            .clipShape(Capsule())
                            .shadow(radius: 4)
                    }
                    .padding()
                    
                    Button(action: {
                        viewManager.currentView = .main
                    }){
                            Text("Back")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: geo.size.width / 3, height: geo.size.height / 10)
                                .background(Color.purple)
                                .clipShape(Capsule())
                                .shadow(radius: 4)
                    }
                }
            }
            .alert(isPresented: $isShowingAlert){
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("Dismiss:")))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewManager: ViewManager())
    }
}
