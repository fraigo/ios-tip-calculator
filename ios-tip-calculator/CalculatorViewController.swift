//
//  ViewController.swift
//  ios-tip-calculator
//
//  Created by Francisco on 2018-10-22.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Controls input text to filter characters
        billAmountTextField.delegate = self;
        // keyboard show notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        // keyboard hide notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        //Default calculation
        calculateTip()
    }
    
    override func viewDidLayoutSubviews() {
        // Sets the contentSize of the scrollView
        scrollView.contentSize = CGSize(width: stackView.frame.size.width, height: stackView.frame.size.height+stackView.spacing)
    }
    
    @objc func keyBoardDidShow(notification:NSNotification){
        print("Keyboard on")
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue) {
            // Scroll to the bill amount text field
            if billAmountTextField.isFirstResponder{
                showKeyboard(textField: billAmountTextField, keyboardSize: keyboardSize)
            }
            // Scroll to the tip percentage text field (now disabled)
            if tipPercentageTextField.isFirstResponder{
                showKeyboard(textField: tipPercentageTextField, keyboardSize: keyboardSize)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            textField.resignFirstResponder()
            //or
            //self.view.endEditing(true)
            return true
    }
    
    @objc func keyBoardDidHide(notification:NSNotification){
        print("Keyboard off")
    }
    
    func showKeyboard(textField:UITextField, keyboardSize: NSValue){
        // auto-select text from field
        textField.selectAll(nil)
        // compute if textView is out of view
        let screenSize = UIScreen.main.bounds
        let result = textField.superview?.convert(textField.frame, to: nil)
        let textBottom = (result?.origin.y)! + textField.frame.height
        let keyboardTop = screenSize.height - keyboardSize.cgRectValue.height
        print(textBottom, keyboardTop, keyboardSize)
        if (textBottom > keyboardTop){
            UIView.animate(withDuration: 0.3, animations: {
                print("Scroll to", textField.frame.origin)
                // scroll view to the label and text field
                self.scrollView.setContentOffset(textField.frame.origin.translateY(-self.stackView.spacing * 1.5), animated: true)
            })
        }
    
        
    }
    
    @IBAction func editAmount(_ sender: Any) {
        // auto-calculate on edit amount
        calculateTip()
    }
    
    @IBAction func adjustTipPercentage(_ sender: Any) {
        // auto-calculate on percentage change
        calculateTip()
    }
    
    
    func updateTipPercentage(){
        // update text associated to percentage slider
        tipPercentageTextField.text = String(Int(tipPercentageSlider.value)) + " %"
    }
    
    
    @IBAction func touchUpInside(_ sender: Any) {
        // calculate on button press
        calculateTip()
    }
    
    func calculateTip(){
        updateTipPercentage()
        let amount = Int(billAmountTextField.text!) ?? 0
        let percentage = Int(tipPercentageSlider.value)
        tipAmountLabel.text = "$\(String(amount * percentage / 100))"
    }
    
    
    

}



extension CalculatorViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        // allow only input digits
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

extension CGPoint {
    
    func translateY(_ y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x, y: self.y + y)
    }
}
