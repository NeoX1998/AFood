//
//  TDEEViewController.swift
//  AFood
//
//  Created by 許博皓 on 2023/1/16.
//

import UIKit

class TDEEViewController: ViewController {

    var TDEE : Double = 0
    var BMR : Double = 0
    var isFemale : Bool = false
    var tag = 0
    var isReasonable : Bool = true
    
    @IBOutlet weak var gender: UIButton!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var dailyActivityLevel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setPopupButton()
    }
    
    func setPopupButton() {
        gender.menu = UIMenu(children : [
            UIAction(title : "Male", state : .on, handler: { [self] action in
                isFemale = false
            }),
            UIAction(title: "Female", handler: { [self] action in
                isFemale = true
            })])
        
        gender.showsMenuAsPrimaryAction = true
        gender.changesSelectionAsPrimaryAction = true
        
        dailyActivityLevel.menu = UIMenu(children : [
            UIAction(title : "Not exercising", state : .on, handler : { [self] action in
                tag = 0
            }),
            UIAction(title: "Exercise 1~3 days a week", handler: { [self] action in
                tag = 1
            }),
            UIAction(title: "Exercise 3~5 days a week", handler: { [self] action in
                tag = 2
            }),
            UIAction(title: "Exercise 6~7 days a week", handler: { [self] action in
                tag = 3
            }),
            UIAction(title: "Exercise all the time", handler: { [self] action in
                tag = 4
            })])

        dailyActivityLevel.showsMenuAsPrimaryAction = true
        dailyActivityLevel.changesSelectionAsPrimaryAction = true
        
    }
    
    @IBAction func calculate(_ sender: Any) {
        if height.text == "" || weight.text == "" || age.text == ""  {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("We can't proceed because some fields is blank. Please note that all fields are required.", comment: "Fill in the required fields"), preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if Double(height.text ?? "")! < 140 || Double(height.text ?? "")! > 230 || Double(weight.text ?? "")! < 30 || Double(weight.text ?? "")! > 200 || Double(age.text ?? "")! < 15 || Double(age.text ?? "")! > 120 {
            isReasonable = false
        }
        
        if isReasonable == false {
            let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("We can't proceed because some fields are unreasonable. The following are acceptable ranges for the all fields : \nHeight : 140 ~ 230 \nWeight : 30 ~ 200 \n Age : 15 ~ 120", comment: "Fill in the reasonable fields"), preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            isReasonable = true
            
            return
        }
        
        if isFemale == true {
            BMR = (10 * Double(weight.text ?? "")!) + (6.25 * Double(height.text ?? "")!) - (5 * Double(age.text ?? "")!) - 161
        }else {
            BMR = (10 * Double(weight.text ?? "")!) + (6.25 * Double(height.text ?? "")!) - (5 * Double(age.text ?? "")!) + 5
        }
        
        if tag == 0 {
            TDEE = BMR * 1.2
        }else if tag == 1 {
            TDEE = BMR * 1.375
        }else if tag == 2 {
            TDEE = BMR * 1.55
        }else if tag == 3 {
            TDEE = BMR * 1.725
        }else if tag == 4 {
            TDEE = BMR * 1.9
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { //設定點擊空白處關閉鍵盤
            view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTDEE" {
            let destinationVC = segue.destination as? TDEEResultViewController
            destinationVC?.answer = TDEE
        }
    }

}
