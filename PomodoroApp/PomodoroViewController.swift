//
//  PomodoroViewController.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 24/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit

public protocol PomodoroViewControllerDelegate {
    func didTapStartButton(last pomodoro: Pomodoro?)
}


class PomodoroViewController: UIViewController {
    
    var count = 1500
    
    var timer = Timer()
    
    var counting: Bool = false

    let pomodoroService = PomodoroService()
    
    @IBOutlet weak var pomodoroImageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
}


extension PomodoroViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerLabel.text = "25:00"
        
        startButton.addTarget(self,
                              action: #selector(PomodoroViewController.tapStartButton),
                              for: .touchUpInside)
    }
}


extension PomodoroViewController {
    
    func savePomodoro(_ sample: Sample) {
        pomodoroService.save(sample) { (error) in
            print("Error = \(error.debugDescription)")
        }
    }
}


extension PomodoroViewController {
    
    func tapStartButton() {
        
        if !counting {
            
            counting = true
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PomodoroViewController.counter), userInfo: nil, repeats: true)
            
            startButton.setTitle("Stop", for: .normal)
            
        } else  {
            
            counting = false
            
            timer.invalidate()
            
            startButton.setTitle("Start", for: .normal)
            
            let stoppedSample = Sample(newTimer: timerLabel.text ?? "",
                                       newState: "stopped")

            savePomodoro(stoppedSample)
            
            timerLabel.text = "25:00"
            
        }
    }
}


extension PomodoroViewController {

    //MARK: Counter
    
    func counter() {
    
        count -= 1
        
        if count == 00 {
            
            timer.invalidate()
            
            let fineshedSample = Sample(newTimer: timerLabel.text ?? "",
                                       newState: "fineshed")
            
            savePomodoro(fineshedSample)
            
            startButton.setTitle("Start", for: .normal)

            timerLabel.text = "25"
        }

        timerLabel.text = "\(timeString(TimeInterval(count)))"
    }
    
    
    //MARK: Format Timer
    
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
