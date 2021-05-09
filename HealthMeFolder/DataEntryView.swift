//
//  DataEntry_View.swift
//

// WARNING: NO INPUT VALIDATION IN PLACE



import SwiftUI
import Firebase

struct DataEntryView: View {
    @ObservedObject var users:Users
    
    let isRegistering:Bool
    
    @State var hr = ""
    @State var weight = ""
    @State var height = ""
    @State var gender = ""
    @State var time = ""
    @State var inCal = ""
    @State var outCal = ""
    @State var name = ""
    @State var username = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    @State var alertMsg = ""
    @State var alertTitle = ""
    @State var showingAlert = false
    
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                VStack{
                    Form{
 
                        
                            Section(header: Text("Vitals")){
                                TextField("Heartrate (beats per min)", text: $hr)
                                    .keyboardType(.numberPad)
                                TextField("Blood Pressure ", text: $height)
                                    .keyboardType(.numberPad)
                            }
                            Section(header: Text("Activity")){
                                TextField("Weight (lbs)", text: $weight)
                                    .keyboardType(.numberPad)
                                TextField("Activity Time (min)", text: $time)
                                    .keyboardType(.numberPad)

                                TextField("Calories in", text: $inCal)
                                    .keyboardType(.numberPad)

                                TextField("Calories out", text: $outCal)
                                    .keyboardType(.numberPad)
                            }
                        

                    }
                    Button(action: {
                        setName()
                        
                    }){
                        Text("Continue")
                            .font(.headline)
                            .bold()
                            .padding()
                            .frame(width: geo.size.width - geo.size.width / 4, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.blue)
                    }
                    .padding(.vertical)
                    .disabled(password != confirmPassword)
                }
            }
            .alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("Dismiss")))
            }
            .navigationTitle("How was your day?")
        }
    }
    
    func setName(){
        if let user = Auth.auth().currentUser{
            let userChangeRequest = user.createProfileChangeRequest()
            userChangeRequest.displayName = name
            
            userChangeRequest.commitChanges{ error in
                if error != nil{
                    alertTitle = "Error"
                    alertMsg = error?.localizedDescription ?? "Error"
                    showingAlert = true
                }
            }
        }
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DataEntryView(users: Users(), isRegistering: true)
            .preferredColorScheme(.dark)
    }
}
