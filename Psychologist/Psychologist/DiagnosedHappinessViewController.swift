//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by iOS Students on 5/11/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController : HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int] {
        get { return defaults.objectForKey(History.DefaultKey) as? [Int] ?? [] }
        set { defaults.setObject(newValue, forKey: History.DefaultKey) }
    }
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    // need to add UIPopoverPresentationControllerDelegate
                    // or it won't work on iphone
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
                
            }
        }
    }
    // because we add UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
