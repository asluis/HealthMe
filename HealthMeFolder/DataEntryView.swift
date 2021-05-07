//
//  DataEntry_View.swift
//

// WARNING: NO INPUT VALIDATION IN PLACE



import SwiftUI

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
    @State var showingAlert = false
    let alertTitle = "Incorrect Data"

    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                VStack{
                    Form{
                        if isRegistering{
                            Section(header: Text("Registration information")){
                                TextField("Name", text: $name)
                                TextField("Gender", text: $gender)
                                TextField("Username", text: $username)
                                SecureField("Password", text: $password)
                                SecureField("Password", text: $confirmPassword)
                            }
                        }
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
                        // TODO: action
                    }){
                        Text(isRegistering ? "Register" : "Continue")
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
            .navigationTitle("How was your day?")
        }
    }
}

struct DataEntryView_Previews: PreviewProvider {
    static var previews: some View {
        DataEntryView(users: Users(), isRegistering: true)
            .preferredColorScheme(.dark)
    }
}
