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
        filter.cutoffFrequency = 20 + x * (22_050 - 20)
        filter.resonance = -20 + (1 - y) * (40 - (-20))
        delay.time = 0.1 + (1 - y) * (1.0 - 0.1)
    }
    
    @IBOutlet weak var containerView: UIView!
    
    var generator: AKOscillator!
    var envelope: AKAmplitudeEnvelope!
    var filter: AKLowPassFilter!
    var delay: AKDelay!
    
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
            let waveform = AKTable(.sawtooth)
            generator = AKOscillator(waveform: waveform)
            generator.rampDuration = 0
            filter = AKLowPassFilter(generator)
            filter.cutoffFrequency = 220
            envelope = AKAmplitudeEnvelope(filter)
            envelope.attackDuration = 0
            delay = AKDelay(envelope)
            delay.time = 0.5
            let mixer = AKMixer(delay, envelope)
            
            AudioKit.output = mixer
            try AudioKit.start()
            generator.start()
        } catch let e {
            fatalError(e.localizedDescription)
        }
        
        
        
    }
    
    func noteOn(note: MIDINoteNumber) {
        let freq = note.midiNoteToFrequency()
        generator.frequency = freq
        envelope.start()
    }
    
    func noteOff(note: MIDINoteNumber) {
        envelope.stop()
    }
    
}

