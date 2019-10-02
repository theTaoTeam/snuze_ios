//
//  AlarmExtensions.swift
//  snuze
//
//  Created by Scott Clampet on 9/19/19.
//  Copyright © 2019 Tao Team. All rights reserved.
//

import UIKit
import MediaPlayer

//MARK: Alarm
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
        alarmTime.hour = meridian == "PM" ? hour + 12 : hour
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
            alarmTimer!.invalidate()
        }
        
        stopAlarmAudio()
        
        print("Setting alarm to sound in \(secondsTillAlarm) seconds")
        if player == nil {
            prepareAlarmAudio()
        }
        
        // Set a timer to fire at the chosen alarm time
        alarmTimer = Timer.scheduledTimer(withTimeInterval: secondsTillAlarm, repeats: false) { [weak self] (timer) in
            self?.startAlarmWithAudio()
            print("alarm triggering")
        }
    }
    
    private func startAlarmWithAudio() {
        print("ALARM IS GOING OFF NOW!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        
        playAlarmAudio()
        alarmTimer = nil
    }
}

//MARK: Audio
extension AlarmViewController: AVAudioPlayerDelegate {
    func setupAudioEnvironment() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }
        catch {
            print("Could not set audio category. Error: \(error)")
        }
    }
    
    fileprivate func prepareAlarmAudio() {
        if let audioURL = Bundle.main.url(forResource: "problemas", withExtension: "wav") {
            if player != nil {
                return
            }
            else {
                do {
                    player = try AVAudioPlayer(contentsOf: audioURL)
                    player!.prepareToPlay()
                    player!.delegate = self
                }
                catch {
                    print("Error preparing audio. Error: \(error)")
                }
            }
        }
    }
    
    fileprivate func playAlarmAudio() {
        if player == nil {
            prepareAlarmAudio()
        }
        
        player?.play()
        audioStartTime = Date()
    }
    
    fileprivate func stopAlarmAudio() {
        player?.stop()
        player?.currentTime = 0
    }
    
    
    //MARK:- AVAUDIOPLAYER DELEGATE
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let maxAlarmPlayingTime:TimeInterval = 60 * 10
        if let startTime = audioStartTime, Date().timeIntervalSince(startTime) < maxAlarmPlayingTime {
            player.play()
        }
        else {
            alarmTimer = nil
        }
    }
}
