//
//  CustomTimePicker.swift
//  snuze
//
//  Created by Scott Clampet on 9/18/19.
//  Copyright © 2019 Tao Team. All rights reserved.
//

import UIKit


class CustomTimePicker: UIPickerView {
    let minutes = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    let hours = [1,2,3,4,5,6,7,8,9,10,11,12]
    let meridians = ["AM", "PM"]
    let separator = [":"]
    
    let customWidth: CGFloat = 50
    let customHeight: CGFloat = 50
    let loopingMargin: Int = 10
    
}

//MARK: Delegate
extension CustomTimePicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return customHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return customWidth
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        var rowItem: String

        switch component {
        case 0:
            rowItem = String(hours[row % hours.count])
        case 1:
            rowItem = separator[0]
        case 2:
            rowItem = minutes[row % minutes.count] <= 5 ? "0\(minutes[row % minutes.count])" : String(minutes[row % minutes.count])
        default:
            rowItem = ""
        }
        
        if row < 2 && component == 3 {
            rowItem = meridians[row % meridians.count]
        }
        
        label.text = rowItem
        label.textColor = .white
        label.textAlignment = .center
        label.font = rowItem == ":" ? UIFont.boldSystemFont(ofSize: 36) : UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(label)
        
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // reset the picker to the middle of the long list
        let position: Int
        let count: Int
        switch component {
        case 0:
            position = row % hours.count
            count = hours.count
        case 1:
            position = row % separator.count
            count = separator.count
        case 2:
            position = row % minutes.count
            count = minutes.count
        case 3:
            position = row % meridians.count
            count = meridians.count
        default:
            position = 1
            count = 0
        }
        
        var row = (loopingMargin / 2) * count + position
        
        //keep meridian section from being an infinite loop
        if component == 3 && position == 1 {
            row = 1
        } else if component == 3 && position == 0 {
            row = 0
        }
        
        pickerView.selectRow(row, inComponent: component, animated: false)
    }
}

//MARK: Datasource
extension CustomTimePicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let rowCount: Int
        
        switch component {
        case 0:
            rowCount = hours.count
        case 1:
            rowCount = 1
        case 2:
            rowCount = minutes.count
        case 3:
            rowCount = meridians.count
        default:
            rowCount = 0
        }
        
        return rowCount > 1 ? loopingMargin * rowCount : 1
    }
}


