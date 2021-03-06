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
    @StateObject var user:User
    
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
                                    alertMsg = error?.localizedDescription ?? "Error loggin in"
                                
                                    isShowingAlert = true
                                }else{
                                    // Successful login
                                    email = ""
                                    password = ""
                                    
                                   print("SUCCESS LOGGING IN")
                                    // Now probe database and fetch user data
                                    let ref = Database.database().reference()
                                    ref.child("users").child(result!.user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                                        
                                        let value = snapshot.value as? NSDictionary
                                        let inputCount = value?["inputCount"] as? Int ?? 0
                                        let weightSum = value?["weightSum"] as? Double ?? 0.0
                                        let heartRateSum = value?["heartRateSum"] as? Int ?? 0
                                        let activityTimeSum = value?["activityTimeSum"] as? Int ?? 0
                                        let weight = value?["weight"] as? Double ?? 0.0
                                        let height = value?["height"] as? Int ?? 0
                                        let gender = value?["gender"] as? String ?? "Genderless ghoul"
                                        let heartRate = value?["heartRate"] as? Int ?? 0
                                        let activityTime = value?["activityTime"] as? Int ?? 0
                                        let inCal = value?["inCal"] as? Int ?? 0
                                        let outCal = value?["outCal"] as? Int ?? 0
                                        let name = value?["name"] as? String ?? "Nameless"
                                        user.replaceData(weight: weight, height: height, gender: gender, heartRate: heartRate, time: activityTime, inCal: inCal, outCal: outCal, inCount: inputCount, wSum: weightSum, hrSum: heartRateSum, atSum: activityTimeSum, name: name)
                                        
                                        viewManager.currentView = .home
                                    })
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
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("Dismiss")))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewManager: ViewManager(), user: User(weight: 0, height: 0, gender: "", heartRate: 0, time: 0, inCal: 0, outCal: 0, inCount: 0, wSum: 0, hrSum: 0, atSum: 0))
    }
}
