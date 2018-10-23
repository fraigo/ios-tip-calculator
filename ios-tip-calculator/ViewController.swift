//
//  ViewController.swift
//  ios-tip-calculator
//
//  Created by Francisco on 2018-10-22.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardNotification(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    @objc func keyBoardNotification(notification:NSNotification){
        print("Keyboard on")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func touchUpInside(_ sender: Any) {
        let amount = Int(billAmountTextField.text!) ?? 0
        let percentage = Int(tipPercentageTextField.text!) ?? 0
        tipAmountLabel.text = String(amount * percentage / 100)
    }
    

}

