//
//  HistoryViewController.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 24/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pomodoros: [Section] = []
    
    var pomodoroService = PomodoroService()
    
    let cellIdentifier = "BasicCell"
    
}



extension HistoryViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pomodoro App"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPomodoros()
    }
    
}


extension HistoryViewController {

    func loadPomodoros() {
        pomodoroService.fetch { [weak self] samples in
            self?.pomodoros = samples
        }
        
        tableView.reloadData()
    }
}


extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pomodoros[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pomodoros[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HistoryViewCell
        
        let pomodoro = pomodoros[indexPath.section].items[indexPath.row]
        cell.setup(with: pomodoro)
        
        return cell
    }
    
}
