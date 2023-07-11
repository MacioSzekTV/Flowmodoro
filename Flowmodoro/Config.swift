//
//  Config.swift
//  Flowmodoro
//
//  Created by Maciej Łabędź on 10/07/2023.
//

import Foundation

class Config: ObservableObject {
    
    enum Mode{
        case focus
        case fbreak
        case pause
        case stop
    }
    
    @Published var mode: Mode = .stop
    
    var timeinSec = 0
    
    var timeS = 0
    var timeM = 0
    var timeH = 0
    
    var timeSL = "00"
    var timeML = "00"
    var timeHL = "00"
    
    @Published var timeElapsed = "00:00:00"
    
    var timer = Timer()
    var timerB = Timer()
    
    var breakTime = 0
    
    func resetTimer(timer: Timer){
        timeinSec = 0
        timeS = 0
        timeH = 0
        timeM = 0
        timeSL = "00"
        timeHL = "00"
        timeML = "00"
        timeElapsed = "00:00:00"
        timer.invalidate()
    }
    
    func startFocus(){
        mode = .focus
        self.breakTime = 0
        resetTimer(timer: self.timerB)
        resetTimer(timer: self.timer)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){t in
            self.timeinSec += 1
            self.timeS += 1
            if(self.timeS == 60){
                self.timeS = 0
                self.timeM += 1
            }
            if(self.timeM == 60){
                self.timeM = 0
                self.timeH += 1
            }
            if(self.timeS<10){
                self.timeSL = "0" + String(self.timeS)
            }else{
                self.timeSL = String(self.timeS)
            }
            
            if(self.timeM<10){
                self.timeML = "0" + String(self.timeM)
            }else{
                self.timeML = String(self.timeM)
            }
            
            if(self.timeH<10){
                self.timeHL = "0" + String(self.timeH)
            }else{
                self.timeHL = String(self.timeH)
            }
            
            self.timeElapsed = self.timeHL + ":" + self.timeML + ":" + self.timeSL
        }
    }
    
    func startBreak(){
        mode = .fbreak
        
        breakTime = timeinSec / 5
        print(breakTime)
        
        resetTimer(timer: timer)
        
        timeS = breakTime

        timerB = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){t in
            self.timeS -= 1
            
            if(self.timeS>=60){
                self.timeM = self.timeS/60
                self.timeS = self.timeS - self.timeM*60
                if(self.timeM>=60){
                    self.timeH = self.timeM/60
                    self.timeM = self.timeM - self.timeH*60
                }
            }
            
            if(self.timeS<10){
                self.timeSL = "0" + String(self.timeS)
            }else{
                self.timeSL = String(self.timeS)
            }
            
            if(self.timeM<10){
                self.timeML = "0" + String(self.timeM)
            }else{
                self.timeML = String(self.timeM)
            }
            
            if(self.timeH<10){
                self.timeHL = "0" + String(self.timeH)
            }else{
                self.timeHL = String(self.timeH)
            }
            
            self.timeElapsed = self.timeHL + ":" + self.timeML + ":" + self.timeSL
            if(self.timeS <= 0){
                if(self.timeM == 0 && self.timeH == 0){
                    self.resetTimer(timer: self.timerB)
                    self.startFocus()
                }else{
                    if(self.timeM>0){
                        self.timeS = 60
                        self.timeM -= 1
                    }else{
                        self.timeS = 60
                        self.timeM = 59
                        self.timeH -= 1
                    }
                }
            }
        }
        
    }
    
    func pause(){
        mode = .pause
        timer.invalidate()
    }
    
    func stop(){
        mode = .stop
        timeS = 0
        timeH = 0
        timeM = 0
        timeSL = "00"
        timeHL = "00"
        timeML = "00"
        timeElapsed = "00:00:00"
        timer.invalidate()
    }
}
