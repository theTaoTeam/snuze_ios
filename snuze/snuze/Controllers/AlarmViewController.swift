//
//  ViewController.swift
//  snuze
//
//  Created by Scott Clampet on 9/18/19.
//  Copyright © 2019 Tao Team. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {
    var alarmTimer:Timer?
//    var player:AVAudioPlayer? 
    var customTimePicker: CustomTimePicker!
    
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    
    let alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("set alarm", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 15
        button.tintColor = .blue
        button.addTarget(self, action: #selector(setAlarm), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavBar()
        setupTimePicker()
        
        view.addSubview(timePicker)
        view.addSubview(alarmButton)
        

        timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 100)
        
        view.addConstraintsWithFormat(format: "V:[v0(50)]-200-|", views: alarmButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: timePicker)
        view.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: alarmButton)
        
    }
}

//MARK: Helper Methods
extension AlarmViewController {
    
    fileprivate func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            navBar.isHidden = true
        }
    }
    
    fileprivate func setupTimePicker() {
        customTimePicker = CustomTimePicker()
        timePicker.delegate = customTimePicker
        timePicker.dataSource = customTimePicker
        

        for component in 0...3 {
            if component == 0 || component == 2 {
                timePicker.selectRow(customTimePicker.loopingMargin / 2, inComponent: component, animated: false)
            } else {
                timePicker.selectRow(0, inComponent: component, animated: false)
            }

        }
    }
    
    @objc func setAlarm() {
        let hours = customTimePicker.hours
        let minutes = customTimePicker.minutes
        let meridianIndex = timePicker.selectedRow(inComponent: 3)
        let hourIndex = timePicker.selectedRow(inComponent: 0) % customTimePicker.loopingMargin
        let minutesIndex = timePicker.selectedRow(inComponent: 2) % customTimePicker.loopingMargin
        print(hourIndex)
        setAlarmForDeviceAlwaysOnMode(hour: hours[hourIndex], minute: minutes[minutesIndex], meridian: customTimePicker.meridians[meridianIndex])
    }
    
}

