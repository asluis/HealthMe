//
//  User.swift
//  CMPE_131_UI
//
//  Created by Luis Alvarez on 5/4/21.
//

import Foundation



class Users:ObservableObject {
    @Published var users:[User]
    
    init(){
        users = [User]()
    }
}

struct User{
    var weight = [Float]()
    let height:Int // inches
    var gender = ""
    var heartRate = [Int]()
    var activityTime = [Int]() // minutes
    var inCal = [Int]()
    var outCal = [Int]()
    
    init(weight:Float, height:Int, gender:String, heartRate:Int, time:Int, inCal:Int, outCal:Int){
        self.weight.append(weight)
        self.height = height
        self.gender = gender
        self.heartRate.append(heartRate)
        self.activityTime.append(time)
    }
    
    mutating func addData(weight:Float, heartRate:Int, time:Int, inCal:Int, outCal:Int){
        self.weight.append(weight)
        self.heartRate.append(heartRate)
        self.activityTime.append(time)
        self.inCal.append(inCal)
        self.outCal.append(outCal)
    }
    
}
