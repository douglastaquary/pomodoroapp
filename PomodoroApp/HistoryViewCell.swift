//
//  HistoryViewCell.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 28/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit
import CoreData


class HistoryViewCell: UITableViewCell {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var relativeTimeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = false

    }

    
    func setup(with item: NSManagedObject) {

        timerLabel.text = item.value(forKey: "timer") as? String
        statusLabel.text = item.value(forKey: "state") as? String
        
        let sampleDate = item.value(forKey: "relativeTime") as? Date
        
        relativeTimeLabel.text = Date().relativePast(for: sampleDate!)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
