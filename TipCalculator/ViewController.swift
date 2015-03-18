//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kelly Lim on 2/11/15.
//  Copyright (c) 2015 Kelly Lim. All rights reserved.
//

import UIKit
//if importing a framework that imports another framework, don't need to because import UIKit already

class ViewController: UIViewController {
// IBOutlet connecting the things that will be interactive/will change

//weak vs. strong references
    //strong references when object considered the owner - owner if resposible for existence
    
    
    
    @IBOutlet weak var billAmountLabel: UILabel!
    // ! means that it starts at nil and eventually has to have a value to it - knows that once view has been created and UI components have been created then they will actually refer to something in memory
    @IBOutlet weak var customTipPercentLabel1: UILabel!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
   
    //NSDecimalNumber constants used in the calculateTip method
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percet = NSDecimalNumber(string: "0.15")
    
    // This comment does nothing
    // This comment also does nothing
    // This is yet another comment that does nothing
    
    override func viewDidLoad() {
    //override vs. overview
        //override - call parent class version of it first then do other stuff
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //don't want to access any IBOutlet orders untilDidLoad
        
        //select inputTextField so keypad displays when the view loads - FirstResponder means get first crack at any actions
        inputTextField.becomeFirstResponder()
    }

    @IBAction func calculateTip(sender: AnyObject) {
    //AnyObject so same function can be used if input is typed or if dictated by slider - lets it be ambiguous
        
        let inputString = inputTextField.text // get user input
        // convert slider value to an NSDecimal Number
        let sliderValue = NSDecimalNumber(integer: Int(customTipPercentageSlider.value))
        //divide sliderValue by decimal100 to get tip %
        let customPercent = sliderValue/decimal100
        
        // did customTipPercentageSlider generate the event?
        if sender is UISlider {
            //thumb moved so update the Labels with new custom percent
            customTipPercentLabel1.text = NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: NSNumberFormatterStyle.PercentStyle)
            customTipPercentLabel2.text = customTipPercentLabel1.text
        }
        
        // if there is a bill amount, calculate tipds and totals
        if !inputString.isEmpty {
            //convert to NSDecimalNumber and insert decimal point
            let billAmount = NSDecimalNumber(string: inputString)/decimal100
            //did inputTextField generate the event?
            if sender is UITextField {
                // update billAmountLabel with currency-formatted total
                billAmountLabel.text = " " + formatAsCurrency(billAmount)
                // calculate and display the 15% tip and total
                let fifteenTip = billAmount * decimal15Percet
                tip15Label.text = formatAsCurrency(fifteenTip)
                total15Label.text = formatAsCurrency(billAmount + fifteenTip)
            }
            // calculate custom tip and display custom tip and total
            let customTip = billAmount * customPercent
            tipCustomLabel.text = formatAsCurrency(customTip)
            totalCustomLabel.text = formatAsCurrency(billAmount + customTip)
        }
        else { // clear all Labels
            billAmountLabel.text = " "
            tip15Label.text = " "
            total15Label.text = " "
            tipCustomLabel.text = " "
            totalCustomLabel.text = " "
        }
    }
}


//convert a numeric value to localized currency string
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}

//overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

//overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

//overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}

