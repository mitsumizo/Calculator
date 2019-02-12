//
//  ViewController.swift
//  Calculator
//
//  Created by Todd Perkins on 11/13/17.
//  Copyright © 2017 Todd Perkins. All rights reserved.
//

import UIKit

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
    
    var labelString:String = "0"
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
        guard let labelDouble:Double = Double(labelString) else
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
            savedNum /= labelDouble
        }
        
        currentMode = .non_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didResetButton(_ sender: Any) {
        labelString = "0"
        currentMode = .non_set
        savedNum = 0
        lastButtonWasMode = false
        
        resultLabel.text = labelString
    }
    
    
    @IBAction func didNumberButton(_ sender: UIButton)
    {
        let stringValue:String? = sender.titleLabel?.text //stringValue = the string written on the button I don't know if it is number so need optional
        
        if(lastButtonWasMode)
        {
            lastButtonWasMode = false
            labelString = "0"
        }
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    @IBAction func didChangeSign(_ sender: Any) {
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        
        var temp:Double
        labelString = ""
        
        temp = (-1) * labelDouble
        
        labelString = labelString.appending(String(temp))
        
        updateText()
    }
    
    @IBAction func didParcentage(_ sender: Any) {
        
        guard let labelDouble:Double = Double(labelString) else {
            return
        }
        var temp:Double
        labelString = ""
        
        temp = labelDouble / 100
        
        labelString = labelString.appending(String(temp))
        
        updateText()
    }
    
//    @IBAction func didFloat(_ sender: Any) {
//
//        guard let labelDouble:Double = Double(labelString) else {
//            return
//        }
//        if(FloatPoint)
//        {
//            return
//        }
//
//        FloatPoint = true
//        labelString = labelString.appending(".")
//
//        updateText()
//    }
    
    func updateText()
    {
        guard let labelDouble:Double = Double(labelString) else
        {
            return
        }
        
        if(currentMode == .non_set)
        {
            savedNum = labelDouble
        }
        
        resultLabel.text = "\(labelDouble)"
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
    
}

