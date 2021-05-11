//
//  User.swift
//  CMPE_131_UI
//
//  Created by Luis Alvarez on 5/4/21.
//

import Foundation

class User: ObservableObject{
    @Published public var inputCount = 0
    @Published public var weightSum = 0.0
    @Published public var heartRateSum = 0
    @Published public var activityTimeSum = 0
    
    @Published public var weight = 0.0
    @Published public var height:Int // inches
    @Published public var gender = ""
    @Published public var heartRate = 0
    @Published public var activityTime = 0 // minutes
    @Published public var inCal = 0
    @Published public var outCal = 0
    @Published public var name = ""
    
    init(weight:Double, height:Int, gender:String, heartRate:Int, time:Int, inCal:Int, outCal:Int, inCount: Int, wSum: Double, hrSum:Int, atSum:Int, inputCount:Int){
        self.weight = weight
        self.height = height
        self.gender = gender
        self.heartRate = heartRate
        self.activityTime = time
        self.inputCount = inCount
        weightSum = wSum
        heartRateSum = hrSum
        activityTimeSum = atSum
        self.inputCount = inputCount
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
