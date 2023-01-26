//
//  TDEEResultViewController.swift
//  AFood
//
//  Created by 許博皓 on 2023/1/16.
//

import UIKit

class TDEEResultViewController: ViewController {

    var answer : Double = 0
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainLabel.text = "Your TDEE is \(Int(answer))"
    }
    
}
