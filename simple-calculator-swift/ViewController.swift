//
//  ViewController.swift
//  simple-calculator-swift
//
//  Created by Surasak Wattanapradit on 2/28/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLb: UILabel!
    var  btnSound: AVAudioPlayer!
    var runningNumber = ""
    
    enum Operation: String {
        case Devide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "click", ofType: "mp3")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLb.text = "0"
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
    @IBAction func numPressed(sender:UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLb.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Devide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
        currentOperation = Operation.Empty
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Devide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLb.text = result
            }
            
            currentOperation = operation
        } else {
            //First time
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
}

