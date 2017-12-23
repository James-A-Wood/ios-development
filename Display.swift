//
//  Display.swift
//  Timer
//
//  Created by James Wood on 2017/08/31.
//  Copyright © 2017 James Wood. All rights reserved.
//



import Foundation
import UIKit
import AVFoundation


protocol DigitalReadoutDelegate {
    func update(_ clock: Clock, time: Double)
    func onFinish()
}


class Display: DigitalReadoutDelegate {
    
    
    var minutesDisplay: UILabel?
    var secondsDisplay: UILabel?
    var milisecondsDisplay: UILabel?
    var messageWindow: UILabel?
    var view: UIViewController?
    
    var hasEnded: Bool = false
    var onFinishMessage = "Time up!"
    
    var flashDuration: Double = 1
    
    
    init(minutes: UILabel, seconds: UILabel, miliseconds: UILabel, messageWindow: UILabel?) {
        self.minutesDisplay = minutes
        self.secondsDisplay = seconds
        self.milisecondsDisplay = miliseconds
        self.messageWindow = messageWindow
        messageWindow?.text = ""
    }
    
    
    func showMessage(_ text: String) {
        minutesDisplay?.text = ""
        secondsDisplay?.text = ""
        milisecondsDisplay?.text = ""
        messageWindow?.text = text
    }
    
    
    func update(_ clock: Clock, time: Double) {
        
        
        messageWindow?.text = ""
        hasEnded = false
        
        
        let parsed = parseTime(time)
        
        
        var minutes: String = "00"
        if parsed.minutes > 0 {
            minutes = String(format: "%02d", parsed.minutes)
        }
        
        
        // if there are no minutes, then not forcing leading 0's
        var seconds = "\(parsed.seconds)"
        if minutes != "" {
            seconds = String(format: "%02d", parsed.seconds)
        }
        
        
        // miliseconds always has leading 0's
        let miliseconds = (String(format: "%02d", parsed.miliseconds))
        
        
        
        minutesDisplay!.text = "\(minutes):"
        secondsDisplay!.text = "\(seconds)"
        milisecondsDisplay!.text = ".\(miliseconds)"
    }
    
    
    func onFinish() {
        hasEnded = true
        showMessage(onFinishMessage)
        flash()
    }
    
    
    func flash() {
        messageWindow?.alpha = 1
        if hasEnded {
            UIView.animate(withDuration: flashDuration, delay: 0, animations: { () -> Void in
                self.messageWindow?.alpha = 0.5
            }, completion: { (hasEnded) -> Void in
                if hasEnded {
                    self.flash()
                }
            })
        }
    }
    
    
    func parseTime(_ time: TimeInterval) -> (minutes: Int, seconds: Int, miliseconds: Int) {
        let miliseconds = Int(time * 100) % 100
        let seconds = Int(time) % 60
        let minutes = Int(time / 60)
        
        return (minutes, seconds, miliseconds)
    }
}



