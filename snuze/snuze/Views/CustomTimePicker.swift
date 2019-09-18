//
//  CustomTimePicker.swift
//  snuze
//
//  Created by Scott Clampet on 9/18/19.
//  Copyright © 2019 Tao Team. All rights reserved.
//

import UIKit


class CustomTimePicker: UIPickerView {
    let minutes = [00, 05, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    let hours = [1,2,3,4,5,6,7,8,9,10,11,12]
    let meridians = ["am", "pm"]

    

}

extension CustomTimePicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowItem: String
        
        switch component {
        case 0:
            rowItem = String(hours[row])
        case 1:
            rowItem = String(minutes[row])
        case 2:
            print("here")
            rowItem = meridians[row]
        default:
            rowItem = "test"
        }
        return rowItem
    }
}

extension CustomTimePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let rowCount: Int
        
        switch component {
        case 0:
            rowCount = hours.count
        case 1:
            rowCount = minutes.count
        case 2:
            rowCount = meridians.count
        default:
            rowCount = 0
        }
        
        return rowCount
    }
}
