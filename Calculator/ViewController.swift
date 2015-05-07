//
//  ViewController.swift
//  Calculator
//
//  Created by iOS Students on 5/4/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    //var operandStack:Array<Double> = Array<Double>()
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)

        
        NSLog("operandStack = \(operandStack)" )
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
//        println("Tag 1")
        NSLog("CURRENT TITLE = \(operation)")
        
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        NSLog("CALCULATION")
        switch operation {
            case "✖️":
                NSLog("result of x")
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() * operandStack.removeLast()
                    enter()
                }
            case "➗":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() / operandStack.removeLast()
                    enter()
                }
            case "➕":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() + operandStack.removeLast()
                    enter()
                }
            case "➖":
                if operandStack.count >= 2 {
                    displayValue = operandStack.removeLast() - operandStack.removeLast()
                    enter()
                }
            default: break
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
}

