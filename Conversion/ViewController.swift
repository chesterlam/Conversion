//
//  ViewController.swift
//  Conversion
//
//  Created by Chester Lam on 9/2/16.
//  Copyright © 2016 Chester Lam. All rights reserved.
//

import UIKit

extension Float {
    var cleanValue: String {
        return self % 1 == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    
    var picker1Data = [String]()
    var picker2Data = [String]()
    
    var unit1 = ""
    var unit2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker1.tag = 1
        picker2.tag = 2
        
        // Connect data:
        picker1.delegate = self
        picker1.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        
        
        //let firstIndex = pickerView(picker1, titleForRow: 1, forComponent: 1)
        
        
        // Input data into the Array:
        picker1Data = ["in", "ft", "mm", "cm", "m", "km"]
        picker2Data = ["in", "ft", "mm", "cm", "m", "km"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker1Data.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            unit1 = picker1Data[row]
        } else {
            unit2 = picker2Data[row]
        }
       
        text1Changed(text1)
        
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return picker1Data[row]
        } else {
            return picker2Data[row]
        }
        
    }

    func convert(firstUnit: String, secondUnit: String, number: Float) -> Float {
        var number = number
        switch firstUnit {
        case "in":
            switch secondUnit {
            case "ft":
                number = number * 0.0833333
            case "mm":
                number = number * 25.4
            case "cm":
                number = number * 2.54
            case "m":
                number = number * 0.0254
            case "km":
                number = number * 0.0000254
            default:
                break
            }
        case "ft":
            switch secondUnit {
            case "in":
                number = number * 12
            case "mm":
                number = number * 304.8
            case "cm":
                number = number * 30.48
            case "m":
                number = number * 0.3048
            case "km":
                number = number * 0.0003048
            default:
                break
            }
            
        case "mm":
            switch secondUnit {
            case "in":
                number = number * 0.0393701
            case "ft":
                number = number * 0.00328084
            case "cm":
                number = number * 0.1
            case "m":
                number = number * 0.001
            case "km":
                number = number * 0.000001
            default:
                break
            }
            
        case "cm":
            switch secondUnit {
            case "in":
                number = number * 0.393701
            case "ft":
                number = number * 0.0328084
            case "mm":
                number = number * 10
            case "m":
                number = number * 0.01
            case "km":
                number = number * 0.00001
            default:
                break
            }
            
        case "m":
            switch secondUnit {
            case "in":
                number = number * 39.3701
            case "ft":
                number = number * 3.28084
            case "mm":
                number = number * 1000
            case "cm":
                number = number * 100
            case "km":
                number = number * 0.001
            default:
                break
            }
            
        case "km":
            switch secondUnit {
            case "in":
                number = number * 39370.1
            case "ft":
                number = number * 3280.84
            case "mm":
                number = number * 1000000
            case "cm":
                number = number * 100000
            case "m":
                number = number * 1000
            default:
                break
            }
            
        default:
            break
        }
        return number
    }
    
    
    @IBAction func text1Changed(sender: UITextField) {
        var convertUnit: Float?
        if text1.text != nil {
            convertUnit = Float(text1.text!)
        }
        if convertUnit != nil {
            convertUnit = convert(unit1, secondUnit: unit2, number: convertUnit!)
            text2.text = String(convertUnit!.cleanValue)
        } else {
            text2.text = nil
        }
        
    }
    
}

