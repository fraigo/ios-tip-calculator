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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self;
        scrollView.isScrollEnabled = true;
        billAmountTextField.delegate = self;
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        calculateTip()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = stackView.frame.size
    }
    
    @objc func keyBoardDidShow(notification:NSNotification){
        print("Keyboard on")
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue) {
            if billAmountTextField.isFirstResponder{
                showKeyboard(textField: billAmountTextField, keyboardSize: keyboardSize)
            }
            if tipPercentageTextField.isFirstResponder{
                showKeyboard(textField: tipPercentageTextField, keyboardSize: keyboardSize)
            }
        }
    }
    
    @objc func keyBoardDidHide(notification:NSNotification){
        print("Keyboard off")
    }
    
    func showKeyboard(textField:UITextField, keyboardSize: NSValue){
        
        UIView.animate(withDuration: 0.3, animations: {
            print("Scroll to", textField.frame.origin)
            self.scrollView.setContentOffset(textField.frame.origin.translateY(-self.stackView.spacing * 1.5), animated: true)
        })
    
        
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


extension ViewController : UIScrollViewDelegate{
    
    
}


extension ViewController : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

extension CGPoint {
    
    func translateY(_ y: CGFloat) -> CGPoint{
        return CGPoint(x: self.x, y: self.y + y)
    }
}
