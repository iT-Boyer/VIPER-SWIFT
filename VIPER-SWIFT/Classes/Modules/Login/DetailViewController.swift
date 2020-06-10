//
//  DetailViewController.swift
//  hsg.app.login
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018年 clcw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var userName: String!
    @IBOutlet weak var countLabel: UILabel!
    var count: Int = 0 {
        didSet {
            countLabel.text = String(count)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = userName
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if sender.isOn {
            count = count + 1
        } else {
            count = count - 1
        }
    }
}
