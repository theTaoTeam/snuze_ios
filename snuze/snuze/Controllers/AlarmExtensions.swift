//
//  AlarmExtensions.swift
//  snuze
//
//  Created by Scott Clampet on 9/19/19.
//  Copyright © 2019 Tao Team. All rights reserved.
//

import UIKit

extension AlarmViewController {
    
    fileprivate func setAutoLockMode(disabled:Bool) {
        UIApplication.shared.isIdleTimerDisabled = disabled
    }
    
    func setAlarmForDeviceAlwaysOnMode(hour: Int, minute: Int, meridian: String) {
        setAutoLockMode(disabled: true)
        
        let now = Date()
        
        var alarmTime = DateComponents()
        alarmTime.calendar = Calendar.current
        alarmTime.day = Calendar.current.component(.day, from: now)
        alarmTime.month = Calendar.current.component(.month, from: now)
        alarmTime.year = Calendar.current.component(.year, from: now)
        alarmTime.hour = meridian == "AM" ? hour + 12 : hour
        alarmTime.minute = minute
        
        var secondsTillAlarm:TimeInterval = 0
        
        if var date = Calendar.current.date(from: alarmTime) {
            // If alarm time is in the past for today, add 24 hours
            if date < now {
                date = date.addingTimeInterval(24 * 60 * 60)
            }
            
            secondsTillAlarm = date.timeIntervalSince(now)
        }
        
        // Cancel a previously set alarm
        if alarmTimer != nil {
            print("Canceling previous alarm with fire date \(alarmTimer!.fireDate)")
            alarmTimer!.invalidate()
        }
        
//        stopAlarmAudio()
        
        print("Setting alarm to sound in \(secondsTillAlarm) seconds")
//        if player == nil {
//            prepareAlarmAudio()
//        }
        
        // Set a timer to fire at the chosen alarm time
        alarmTimer = Timer.scheduledTimer(withTimeInterval: secondsTillAlarm, repeats: false) { (timer) in
//            self.startAlarmWithAudio()
            print("alarm triggering")
        }
    }
}
