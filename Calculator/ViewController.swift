//
//  ViewController.swift
//  Calculator
//
//  Created by Todd Perkins on 11/13/17.
//  Copyright © 2017 Todd Perkins. All rights reserved.
//

import UIKit

enum CalculatorError:Error {
    case dividedByZero
    case inValidValue
}
enum modes
{
    case non_set
    case addtion
    case substraction
    case multiplication
    case division
}
class ViewController: UIViewController
{
    
    var onTheScreenString:String = "0"
    var currentMode:modes = .non_set
    var savedNum:Double = 0
    var lastButtonWasMode:Bool = false
    var FloatPoint:Bool = false
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didNumberButton(_ sender: UIButton)
    {
        let stringValue:String? = sender.titleLabel?.text //stringValue = the string written on the button I don't know if it is number so need optioal
        if(lastButtonWasMode)
        {
            lastButtonWasMode = false
            onTheScreenString = "0"
        }
        onTheScreenString = onTheScreenString.appending(stringValue!)
        
        updateText()
    }
    @IBAction func didPlusButton(_ sender: Any)
    {
        changeMode(newModes: .addtion)
    }
    @IBAction func didSubstractButton(_ sender: Any)
    {
        changeMode(newModes: .substraction)
    }
    @IBAction func didMultipleButton(_ sender: Any)
    {
        changeMode(newModes: .multiplication)
    }
    @IBAction func didDivideButton(_ sender: Any)
    {
        changeMode(newModes: .division)
    }
    
    @IBAction func didEqualButton(_ sender: Any)
    {
        guard let labelDouble:Double = Double(onTheScreenString) else
        {
            return
        }
        
        if(currentMode == .non_set || lastButtonWasMode)
        {
            return
        }
        
        if(currentMode == .addtion)
        {
            savedNum += labelDouble
        }
        else if(currentMode == .substraction)
        {
            savedNum -= labelDouble
        }
        else if(currentMode == .multiplication)
        {
            savedNum *= labelDouble
        }
        else if(currentMode == .division)
        {
            do
            {
                savedNum = try calDivision(a: savedNum, b: labelDouble)
            } catch
            {
                onTheScreenString = "Not a Number"
                resultLabel.text = onTheScreenString
                return
            }
        }
        
        currentMode = .non_set
        onTheScreenString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didResetButton(_ sender: Any) {
        onTheScreenString = "0"
        currentMode = .non_set
        savedNum = 0
        lastButtonWasMode = false
        FloatPoint = false
        
        resultLabel.text = onTheScreenString
    }
    
    @IBAction func didChangeSign(_ sender: Any) {
        guard let labelDouble:Double = Double(onTheScreenString) else {
            return
        }
        
        var temp:Double
        onTheScreenString = ""
        
        temp = (-1) * labelDouble
        
        onTheScreenString = onTheScreenString.appending(String(temp))
        
        updateText()
    }
    
    @IBAction func didParcentage(_ sender: Any) {
        
        guard let labelDouble:Double = Double(onTheScreenString) else {
            return
        }
        var temp:Double
        onTheScreenString = ""
        
        temp = labelDouble / 100
        
        onTheScreenString = onTheScreenString.appending(String(temp))
        
        updateText()
    }
    
    @IBAction func didFloat(_ sender: Any) {
        if(FloatPoint)
        {
            return
        }

        FloatPoint = true
        onTheScreenString = onTheScreenString.appending(".")
    }
    
    func updateText()
    {
        guard let labelDouble:Double = Double(onTheScreenString) else
        {
            return
        }
        
        
        if(currentMode == .non_set)
        {
            savedNum = labelDouble
        }
        
        if(onTheScreenString.contains(".") && labelDouble != Double(Int(labelDouble)))
        {
            resultLabel.text = "\(labelDouble)"
        }
        else
        {
            resultLabel.text = "\(Int(labelDouble))"
        }
    }
    
    func changeMode(newModes:modes)
    {
        if(savedNum == 0)
        {
            return
        }
        currentMode = newModes
        lastButtonWasMode = true
    }
                
    func calDivision(a:Double, b:Double) throws -> Double
    {
        guard b != 0.0 else {
            throw CalculatorError.dividedByZero
        }
        return a / b
    }
}

