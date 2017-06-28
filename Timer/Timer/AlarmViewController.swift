//
//  AlarmViewController.swift
//  Timer
//
//  Created by ALIA M NEELY on 6/28/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let alarm = Alarm()

    @IBOutlet weak var datePIcker: UIDatePicker!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var alarmButton: UIButton!
   
    // MARK: Private
    
    private func armAlarm() {
        alarm.arm(datePIcker.date)
        switchToAlarmSetView()
    }
    
    private func switchToAlarmSetView() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        
        messageLabel.text = "Your alarm is set!"
        
        if let date = alarm.alarmDate {
            dateLabel.text = dateFormatter.string(from: date)
            datePIcker.date = date
        } else {
            dateLabel.text = ""
        }
        
        alarmButton.setTitle("Cancel Alarm", for: UIControlState())
        datePIcker.isUserInteractionEnabled = false
    }
    
    private dynamic func switchToAlarmNotSetView(_ notification: Notification?) {
        alarm.cancel()
        messageLabel.text = "Your alarm is not set."
        dateLabel.text = ""
        alarmButton.setTitle("Set Alarm", for: UIControlState())
        datePIcker.minimumDate = Date()
        datePIcker.date = Date()
        datePIcker.isUserInteractionEnabled = true
    }

}
