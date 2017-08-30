//
//  HistoryHeaderView.swift
//  PomodoroApp
//
//  Created by Douglas Taquary on 29/08/17.
//  Copyright © 2017 Douglas Taquary. All rights reserved.
//

import UIKit

class HistoryHeaderView: UITableViewCell {
    
    @IBOutlet weak var headerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = false
        
    }
    
    func setup(with name: String) {
        headerNameLabel.text = name
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
