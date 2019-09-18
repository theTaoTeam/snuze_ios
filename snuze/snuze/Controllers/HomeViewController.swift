//
//  ViewController.swift
//  snuze
//
//  Created by Scott Clampet on 9/18/19.
//  Copyright © 2019 Tao Team. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var customTimePicker: CustomTimePicker!
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
//        picker.setValue(UIColor.white, forKey: "textColor")
        return picker
    }()
    
    
    let alarmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("set alarm", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 15
        button.tintColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupTimePicker()
        
        view.addSubview(timePicker)
        view.addSubview(alarmButton)
        
        
        view.addConstraintsWithFormat(format: "V:|[v0]-16-[v1(50)]-200-|", views: timePicker, alarmButton)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: timePicker)
        view.addConstraintsWithFormat(format: "H:|-100-[v0]-100-|", views: alarmButton)
        
    }
}

//MARK: Helper Methods
extension HomeViewController {
    
    fileprivate func setupNavBar() {
        if let navBar = navigationController?.navigationBar {
            navBar.isHidden = true
        }
    }
    
    fileprivate func setupTimePicker() {
        customTimePicker = CustomTimePicker()
        timePicker.delegate = customTimePicker
        timePicker.dataSource = customTimePicker
    }
}

