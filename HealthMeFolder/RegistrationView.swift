//
//  RegistrationView.swift
//  HealthMe
//
//  Created by Luis Alvarez on 5/8/21.
//

import SwiftUI
import FirebaseAuth
import Firebase


struct RegistrationView: View {
    @StateObject var viewManager: ViewManager
    
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var name = ""
    
    @State var isShowingAlert = false
    @State var alertTitle = ""
    @State var alertMsg = ""
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("Background1"), Color("ButtonColor1")]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    

                    Text("Register")
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
                    HStack{
                        Image(systemName: "key")
                        SecureField("Confirm Password", text: $confirmPassword)
                            .autocapitalization(.none)
                    }
                    
                    
                    Button(action:{
                        if !emailIsValid(email){
                            
                        } else if email == "" || password == "" || confirmPassword == "" {
                            alertTitle = "Error Logging in"
                            alertMsg = "Please fill out BOTH email and password"
                            isShowingAlert = true
                            
                        }else if password != confirmPassword {
                            alertTitle = "Confirm password"
                            alertMsg = "Please make sure you correctly confirm your password"
                            isShowingAlert = true
                        }else{
                            // action. Register here
                            Auth.auth().createUser(withEmail: email, password: password) { Result, error in
                                if error != nil {
                                    alertTitle = "Error creating account"
                                    alertMsg = error?.localizedDescription ?? "Error"
                                    isShowingAlert = true
                                }else{
                                    // Success!
                                    
                                    print("SUCCESSFUL REGISTRATION for \(email)!")
                                    viewManager.currentView = .newAdd
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
    
func emailIsValid(_ email: String) -> Bool{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}


}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewManager: ViewManager())
    }
}
