//
//  BezierPathsView.swift
//  Dropit
//
//  Created by iOS Students on 5/13/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

    private var bezierPaths = [String:UIBezierPath]()
    
    func setPath(path: UIBezierPath?, named name: String) {
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for (_, path) in bezierPaths {
            path.stroke()
        }
    }
}
