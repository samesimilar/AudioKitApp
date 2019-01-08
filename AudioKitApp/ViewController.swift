//
//  ViewController.swift
//  AudioKitApp
//
//  Created by Mike Spears on 2018-02-01.
//  Copyright © 2018 MADLab. All rights reserved.
//

import UIKit
import AudioKitUI
import AudioKit

class ViewController: UIViewController, AKKeyboardDelegate, XYViewDelegate {

    @IBOutlet weak var xyView: XYView!
    func updateValues(x: Float, y: Float) {

    }
    
    @IBOutlet weak var containerView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xyView.delegate = self
       
        let frame = containerView.bounds
        let keyboardView = AKKeyboardView(width: Int(frame.width), height: Int(frame.height))
        keyboardView.octaveCount = 2
        keyboardView.firstOctave = 1
        keyboardView.delegate = self
        keyboardView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight, UIView.AutoresizingMask.flexibleWidth]
        containerView.addSubview(keyboardView)
        

        
        do {

        } catch let e {
            fatalError(e.localizedDescription)
        }
        
       

    }

    func noteOn(note: MIDINoteNumber) {
        
    }
    
    func noteOff(note: MIDINoteNumber) {
        
    }

}

