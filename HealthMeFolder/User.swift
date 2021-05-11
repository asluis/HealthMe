//
//  User.swift
//  CMPE_131_UI
//
//  Created by Luis Alvarez on 5/4/21.
//

import Foundation

class User: ObservableObject{
    @Published var inputCount = 0
    @Published var weightSum = 0.0
    @Published var heartRateSum = 0
    @Published var activityTimeSum = 0
    
    @Published var weight = 0.0
    @Published var height:Int // inches
    @Published var gender = ""
    @Published var heartRate = 0
    @Published var activityTime = 0 // minutes
    @Published var inCal = 0
    @Published var outCal = 0
    @Published var name = ""
    
    init(weight:Double, height:Int, gender:String, heartRate:Int, time:Int, inCal:Int, outCal:Int, inCount: Int, wSum: Double, hrSum:Int, atSum:Int){
        self.weight = weight
        self.height = height
        self.gender = gender
        self.heartRate = heartRate
        self.activityTime = time
        inputCount = inCount
        weightSum = wSum
        heartRateSum = hrSum
        activityTimeSum = atSum
    }
    
    func addData(weight:Double, heartRate:Int, time:Int, inCal:Int, outCal:Int){
        inputCount += 1
        self.weightSum = weightSum + weight
        self.weight = weight
        heartRateSum = heartRate + heartRate
        self.activityTimeSum = activityTimeSum + time
        
        self.heartRate = heartRate
        activityTime = time
        self.inCal = inCal
        self.outCal = outCal
    }
}
