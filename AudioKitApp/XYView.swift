//
//  XYView.swift
//  AudioKitApp
//
//  Created by Mike Spears on 2018-02-01.
//  Copyright © 2018 MADLab. All rights reserved.
//

import UIKit

protocol XYViewDelegate: class {
    func updateValues(x: Float, y: Float)
}
class XYView: UIView {
    var delegate: XYViewDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        let point = touch.location(in: self)
        let nx = (point.x - bounds.origin.x) / bounds.size.width
        let ny = (point.y - bounds.origin.y) / bounds.size.height
        
        delegate?.updateValues(x: Float(nx), y: Float(ny))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        
        let point = touch.location(in: self)
        let nx = (point.x - bounds.origin.x) / bounds.size.width
        let ny = (point.y - bounds.origin.y) / bounds.size.height
        
        delegate?.updateValues(x: Float(nx), y: Float(ny))
    }

}
