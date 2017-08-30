//
//  HistoryViewController.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 24/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pomodoros: [Section] = []
    
    var pomodoroService = PomodoroService()
    
    let cellIdentifier = "BasicCell"
    
    let headerCell = "HeaderCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPomodoros()
        
        self.navigationItem.title = "Pomodoro App"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpView()
    }
    
    
    func loadPomodoros() {
        pomodoroService.fetch { [weak self] samples in
            self?.pomodoros = samples
        }
        
        tableView.reloadData()
    }
    
    
    func setUpView() {
        
        let emptyBackground = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.width))
        
        if !pomodoros[0].items.isEmpty {
            
            loadPomodoros()
            
            tableView.backgroundView = nil
            tableView.isHidden = false
            tableView.sectionHeaderHeight = 28
            tableView.separatorStyle = .singleLine
            
        } else {
            
            emptyBackground.backgroundColor = .white
            
            tableView.sectionHeaderHeight = 0.0
            tableView.separatorStyle = .none
            
            
            let emptyText = UILabel(frame: CGRect(x: 100, y: 100, width: self.view.bounds.size.width, height: 100))
            emptyText.translatesAutoresizingMaskIntoConstraints = false
            
            emptyText.text = "Start a pomodoro"
            emptyText.textColor = .black
            emptyText.layer.opacity = 0.5
            emptyText.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightBold)
            emptyBackground.addSubview(emptyText)

            emptyText.centerYAnchor.constraint(equalTo: emptyBackground.centerYAnchor).isActive = true

            emptyText.centerXAnchor.constraint(equalTo: emptyBackground.centerXAnchor).isActive = true

            
            tableView.backgroundView = emptyBackground
            
        }
    }

    
}


@available(iOS 10.0, *)
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: headerCell) as! HistoryHeaderView
        
        headerView.setup(with: pomodoros[section].name)
        
        return headerView
    }
    
}
