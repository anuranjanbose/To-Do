//
//  cellTableViewCell.swift
//  ToDoListApp
//
//  Created by Anuranjan Bose on 29/06/17.
//  Copyright © 2017 Anuranjan Bose. All rights reserved.
//

import Foundation
import UIKit

class cellTableViewCell: UITableViewCell {
    
    var delegate : elementDelegate?

    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var mySwitchOutlet: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func mySwitch(_ sender: UISwitch) {
        
        if sender.isOn == false {
            
            delegate?.change(title: titleLabel.text!)
            
        }
        else {
            
            delegate?.change(title : titleLabel.text!)
        }
    }
   
}


