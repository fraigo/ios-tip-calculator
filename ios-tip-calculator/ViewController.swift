//
//  ViewController.swift
//  ios-tip-calculator
//
//  Created by Francisco on 2018-10-22.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        calculateTip()
    }
    
    @objc func keyBoardDidShow(notification:NSNotification){
        print("Keyboard on")
        if let textView = billAmountTextField {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                let keyboardHeight = keyboardSize.height
                // so increase contentView's height by keyboard height
                let screenSize = UIScreen.main.bounds
                let globalPoint = textView.superview?.convert((textView.frame.origin), to: nil)
                //let keyboardTop = screenSize.height - keyboardHeight
                //let textTop = globalPoint?.y
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    if (textView.isFirstResponder){
                        //self.stackView.bounds.origin.y = textTop! - keyboardTop + textView.frame.height + 1
                        
                    }
                })
            }
        }
        
    }
    
    @IBAction func editAmount(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func adjustTipPercentage(_ sender: Any) {
        
        calculateTip()
    }
    
    
    func updateTipPercentage(){
        tipPercentageTextField.text = String(Int(tipPercentageSlider.value))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchUpInside(_ sender: Any) {
        calculateTip()
    }
    
    func calculateTip(){
        updateTipPercentage()
        let amount = Int(billAmountTextField.text!) ?? 0
        let percentage = Int(tipPercentageSlider.value)
        tipAmountLabel.text = String(amount * percentage / 100)
    }
    
    
    

}

