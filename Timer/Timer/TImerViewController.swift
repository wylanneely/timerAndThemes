//
//  TImerViewController.swift
//  Timer
//
//  Created by ALIA M NEELY on 6/28/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import UIKit

class TImerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegatesDatasources()
        
    }
    
    var timer = Timer()
    
    //MARK: - Outlets
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hoursPickerView: UIPickerView!
    @IBOutlet weak var minutesPickerView: UIPickerView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pickerStackView: UIStackView!
    @IBOutlet weak var progressView: UIProgressView!
    
    //MARK: - PickerView Delegate and Datasource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView === hoursPickerView {
            return 24
        } else if pickerView === minutesPickerView {
            return 60
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === hoursPickerView {
            return String("\(row) hours") }
        else if pickerView === minutesPickerView {
            return String("\(row) minutes") } else {
            return String(row)
        }
    }
    
    //MARK: Private
    
    private func toggleTimer() {
        if timer.isOn {
            timer.stop()
            switchToPickerView()
        } else {
            switchToTimerView()
            
            let hours = hoursPickerView.selectedRow(inComponent: 0)
            let minutes = minutesPickerView.selectedRow(inComponent: 0) + (hours * 60)
            let totalSecondsSetOnTimer = TimeInterval(minutes * 60)
            
            timer.setTimer(totalSecondsSetOnTimer, totalSeconds: totalSecondsSetOnTimer)
            updateTimerBasedViews()
            timer.start()
        }
    }
    
    private func updateTimerLabel() {
        timerLabel.text = timer.timeRemainingString
    }
    
    private func updateProgressView() {
        
        let secondsElasped = timer.totalSeconds - timer.secondsRemaining
        let progress = Float(secondsElasped) / Float(timer.totalSeconds)
        progressView.setProgress(progress, animated: true)
    }
    
    private dynamic func updateTimerBasedViews(_ notification: Notification) {
        updateTimerBasedViews()
    }
    
    private func updateTimerBasedViews() {
        updateTimerLabel()
        updateProgressView()
    }
    
    private dynamic func timerComplete(_ notification: Notification) {
        switchToPickerView()
    }
    
    private func switchToTimerView() {
        timerLabel.isHidden = false
        progressView.setProgress(0.0, animated: false)
        progressView.isHidden = false
        pickerStackView.isHidden = true
        startButton.setTitle("Cancel", for: [])
        
        startButton.setTitleColor(UIColor.blueTimerColor, for: [])
        startButton.layer.borderColor = UIColor.blueTimerColor.cgColor
        pauseButton.setTitleColor(UIColor.lightBlueTimerColor, for: [])
        pauseButton.layer.borderColor = UIColor.lightBlueTimerColor.cgColor
    }
    
    private func switchToPickerView() {
        pickerStackView.isHidden = false
        timerLabel.isHidden = true
        progressView.isHidden = true
        startButton.setTitle("Start", for: [])
        
        startButton.setTitleColor(UIColor.lightBlueTimerColor, for: [])
        startButton.layer.borderColor = UIColor.lightBlueTimerColor.cgColor
        pauseButton.setTitleColor(UIColor.blueTimerColor, for: [])
        pauseButton.layer.borderColor = UIColor.blueTimerColor.cgColor
    }
    
    //MARK: - SetUp Functions
    
    func setupDelegatesDatasources() {
        hoursPickerView.delegate = self
        hoursPickerView.dataSource = self
        minutesPickerView.dataSource = self
        minutesPickerView.delegate = self
    }
    
}
