//
//  ViewController.swift
//  TimerApp
//
//  Created by Alex Billson on 17/05/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func startStopTapped(_ sender: Any) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("Start", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        else {
            timerCounting = true
            startStopButton.setTitle("Stop", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursToMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    
    func secondsToHoursToMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you want to reset the timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
            // do nothing, simply dismisses the alert box
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("Start", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

