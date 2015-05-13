//
//  ViewController.swift
//  Dropit
//
//  Created by iOS Students on 5/13/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController {


    @IBOutlet weak var gameView: UIView!
    
    // fall
    let gravity = UIGravityBehavior()
    
    // collide
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        return lazilyCreatedDynamicAnimator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fall
        animator.addBehavior(gravity)
        
        //collide
        animator.addBehavior(collider)
    }

    var dropsPerRow = 10
    
    var dropSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }

    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        gameView.addSubview(dropView)
        
        // fall
        gravity.addItem(dropView)
        
        //collide
        collider.addItem(dropView)
    }
}

private extension CGFloat {

    static func random(max: Int) -> CGFloat {

        return CGFloat(arc4random() % UInt32(max))

    }

}


private extension UIColor {

    class var random: UIColor {

        switch arc4random()%5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()

        }
    }
}

