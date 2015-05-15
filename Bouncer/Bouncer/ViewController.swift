//
//  ViewController.swift
//  Bouncer
//
//  Created by iOS Students on 5/15/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bouncer = BouncerBehavior()
    lazy var animator: UIDynamicAnimator = { UIDynamicAnimator(referenceView: self.view)} ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
    }
    
    struct Constants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    
    var redBlock: UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if redBlock == nil {
            redBlock = addBlock()
            redBlock?.backgroundColor = UIColor.redColor()
            bouncer.addBlock(redBlock!)
        }
        
        let motionManager = AppDelegate.Mothion.Manager
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
                (data, error) -> Void in
                self.bouncer.gravity.gravityDirection = CGVector(dx: data.acceleration.x, dy: -data.acceleration.y)
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.Mothion.Manager.stopAccelerometerUpdates()
    }
    
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zeroPoint, size: Constants.BlockSize))
        view.addSubview(block)
        return block
    }

}

