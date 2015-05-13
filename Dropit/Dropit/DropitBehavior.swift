//
//  DropitBehavior.swift
//  Dropit
//
//  Created by iOS Students on 5/13/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class DropitBehavior: UIDynamicBehavior {
    
    // fall
    let gravity = UIGravityBehavior()
    
    // collide
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    // elasticity
    lazy var dropBehavior: UIDynamicItemBehavior = {
       let lazilyCreatedDropBehavior = UIDynamicItemBehavior()
        lazilyCreatedDropBehavior.allowsRotation = true    // allow drop frame rotate or not
        lazilyCreatedDropBehavior.elasticity = 0.75
        return lazilyCreatedDropBehavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        
        addChildBehavior(dropBehavior)
    }
    
    func addBarrier(path: UIBezierPath, named name: String) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func addDrop(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
}
