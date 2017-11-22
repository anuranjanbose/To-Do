//
//  ConfirmViewController.swift
//  ToDoListApp
//
//  Created by Anuranjan Bose on 04/07/17.
//  Copyright © 2017 Anuranjan Bose. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    var delegate: elementDelegate?
    var segment : Int?
    
    @IBOutlet weak var confirmLabel: UILabel!
    @IBAction func yes(_ sender: UIButton) {
        delegate?.confirmDelete()
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func no(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if segment == 0 {
            confirmLabel.text = "Are you sure you want to delete all tasks?"
        }
        else if segment == 1 {
            confirmLabel.text = "Are you sure you want to delete all COMPLETED tasks?"
           
        }
        else {
            confirmLabel.text = "Are you sure you want to delete all PENDING tasks?"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
}
