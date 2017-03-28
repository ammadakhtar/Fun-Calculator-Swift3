//
//  ViewController.swift
//  retro calculator
//
//  Created by Ammad on 22/01/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation : String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var runningnumber = ""
    var leftvalstr = ""
    var rightvalstr = ""
    var currentoperation : Operation = Operation.Empty
    var result = ""
 
    @IBOutlet weak var OutputLbl: UILabel!
    var btnSound : AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    
        
    let path = Bundle.main.path(forResource: "btn", ofType: "wav")
    
    let soundUrl = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
          }
        catch let err as NSError
          {
            print(err.debugDescription)
          }
        
    }
    
    @IBAction func numberPressed (sender: UIButton)
        {
           playsound()
           runningnumber += "\(sender.tag)"
           OutputLbl.text = runningnumber
        }
    
   func playsound()
    {
        if btnSound.isPlaying
        {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    @IBAction func OnDividePressed(_ sender: Any) {
        processoperation(op: Operation.Divide)
    }

    @IBAction func OnMultiplyPressed(_ sender: Any) {
        processoperation(op: Operation.Multiply)
    }

    @IBAction func OnSubtractPressed(_ sender: Any) {
        processoperation(op: Operation.Subtract)
    }
    
    @IBAction func OnAddPressed(_ sender: Any) {
        processoperation(op: Operation.Add)
    }
    
    @IBAction func OnEqualsPressed(_ sender: Any) {
        processoperation(op: currentoperation)
    }
    
    func processoperation (op: Operation){
    playsound()
        if currentoperation != Operation.Empty
        {
            if runningnumber != ""
            {
                rightvalstr = runningnumber
                runningnumber = ""
                
                if currentoperation == Operation.Divide{
                    result = "\(Double(leftvalstr)! / Double (rightvalstr)!)"
                }else if currentoperation == Operation.Multiply {
                    result = "\(Double(leftvalstr)! * Double (rightvalstr)!)"
                }else if currentoperation == Operation.Add{
                    result = "\(Double(leftvalstr)! + Double (rightvalstr)!)"
                }else if currentoperation == Operation.Subtract{
                    result = "\(Double(leftvalstr)! - Double (rightvalstr)!)"
                }
                
                leftvalstr = result
                OutputLbl.text = result
            }
           
            currentoperation = op
        }
        else
        {
            leftvalstr = runningnumber
            runningnumber = ""
            currentoperation = op
        }
        
    }
    
    @IBAction func ClearBtnPressed(_ sender: Any) {
        playsound()
        result = ""
        leftvalstr = ""
        rightvalstr = ""
        runningnumber = ""
        currentoperation = Operation.Empty
        OutputLbl.text = "\(Double(0))"
        
    }
    
    
    
    
}

