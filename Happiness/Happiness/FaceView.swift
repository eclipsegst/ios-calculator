//
//  FaceView.swift
//  Happiness
//
//  Created by iOS Students on 5/8/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    var color: UIColor = UIColor.blueColor() { didSet {setNeedsDisplay() } }
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    
    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRation: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMounthHeightRatio: CGFloat = 3
        static let FaceRadiusToMounthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right }
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHoriontalSeperation = faceRadius / Scaling.FaceRadiusToEyeSeparationRation
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        
        switch whichEye {
            case .Left: eyeCenter.x -= eyeHoriontalSeperation / 2
            case .Right: eyeCenter.x += eyeHoriontalSeperation / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        path.lineWidth = lineWidth
        return path
        
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        let mounthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mounthHeight = faceRadius / Scaling.FaceRadiusToMounthHeightRatio
        let mounthVerticalOffset = faceRadius / Scaling.FaceRadiusToMounthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mounthHeight
        
        let start = CGPoint(x: faceCenter.x - mounthWidth / 2, y: faceCenter.y + mounthVerticalOffset)
        let end = CGPoint(x: start.x + mounthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mounthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mounthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        
        let smiliness = 0.75
        let smilePath = bezierPathForSmile(smiliness)
        smilePath.stroke()
    }
    
}
