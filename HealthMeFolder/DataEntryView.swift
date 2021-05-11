//
//  DataEntry_View.swift
//

// WARNING: NO INPUT VALIDATION IN PLACE



import SwiftUI
import Firebase

struct DataEntryView: View {
    
    let isRegistering:Bool
    @StateObject var viewManager:ViewManager
    
    @StateObject var user:User
    
    @State var hr = ""
    @State var weight = ""
    @State var height = ""
    @State var gender = ""
    @State var time = ""
    @State var inCal = ""
    @State var outCal = ""
    @State var name = ""
    @State var heartRate = ""
    
    @State var alertMsg = ""
    @State var alertTitle = ""
    @State var showingAlert = false
    
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                VStack{
                    Form{
                        Section(header: Text("Your info")){
                            TextField("Name", text: $name)
                            TextField("Gender", text: $gender)
                        }
                            Section(header: Text("Vitals")){
                                TextField("Heartrate (beats per min)", text: $hr)
                                    .keyboardType(.numberPad)
                                TextField("Height", text: $height)
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
                        user.name = name
                        print("Name is now \(user.name)")
                        user.gender = gender
                        user.addData(weight: Double(weight)!, heartRate: Int(hr)!, time: Int(time)!, inCal: Int(inCal)!, outCal: Int(outCal)!, height: Int(height)!, name: name)
                        pushUser()
                        viewManager.currentView = .home
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
            self.user.name = name
            userChangeRequest.commitChanges{ error in
                if error != nil{
                    alertTitle = "Error"
                    alertMsg = error?.localizedDescription ?? "Error"
                    showingAlert = true
                }
            }
        }
    }
    
    func pushUser(){
        if let userID = Auth.auth().currentUser?.uid{
            // ie user exists.
            let userData: [String : Any] = [
                "inputCount": user.inputCount as Int,
                "weightSum": user.weightSum as Double,
                "heartRateSum": user.heartRateSum as Int,
                "activityTimeSum": user.activityTimeSum as Int,
                "weight": user.weight as Double,
                "height": user.height as Int,
                "gender": user.gender as String,
                "heartRate": user.heartRate as Int,
                "activityTime": user.activityTime as Int,
                "inCal": user.inCal as Int,
                "outCal": user.outCal as Int,
                "name": user.name as String
            ]
            // Calling firebase reference
            let ref = Database.database().reference()
            ref.child("users").child(userID).setValue(userData)
            alertTitle = "SUCCESS"
            alertMsg = "Successfully uploaded your data!"
            showingAlert = true
        }else{
            fatalError() // just crash at this point
        }
        
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DataEntryView(isRegistering: true, viewManager: ViewManager(), user: User(weight: 0, height: 0, gender: "", heartRate: 0, time: 0, inCal: 0, outCal: 0, inCount: 0, wSum: 0, hrSum: 0, atSum: 0))
            .preferredColorScheme(.dark)
    }
}
