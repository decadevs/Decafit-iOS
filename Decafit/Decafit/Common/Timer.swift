//
//  Timer.swift
//  Decafit
//
//  Created by Decagon on 18/08/2022.
//

import UIKit
import SwiftySound
class DecaTimer {
    var timeLeft: TimeInterval
    var endTime: Date?
    var timer = Timer()
    var isTimerRunning = false
    var timeLabel: UILabel
    
    
    init(timeLabel: UILabel, timeLeft: TimeInterval) {
        self.timeLabel = timeLabel
        self.timeLeft = timeLeft
    }
    func invalidate() {
        timer.invalidate()
    }
    func startTimer() {
        if isTimerRunning == false {
            runTimer()
        }
    }
    
    func runTimer() {
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                     selector: (#selector(updateTimer)),
                                     userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTimer() {
        if timeLeft > 0 {
            timeLeft = endTime?.timeIntervalSinceNow ?? 0
            timeLabel.text = timeLeft.time
        } else {
            timer.invalidate()
//            Sound.play(file: "sound-effect.mp3")
            timeLabel.text = "00:00"
        }
    }

    func stopTimer() {
        if isTimerRunning {
            timer.invalidate()
        }
        isTimerRunning = false
    }
    func resetTimer(timeLeft: TimeInterval) {
        timeLabel.text = "\(timeLeft)"
        self.timeLeft = timeLeft
        stopTimer()

    }
}
