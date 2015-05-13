//
//  ViewController.swift
//  Cassini
//
//  Created by iOS Students on 5/12/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let ivc = segue.destinationViewController as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "earth":
                        ivc.imageURL = DemoURL.NASA.Earth
                        ivc.title = "Earth"
                    case "cassini":
                        ivc.imageURL = DemoURL.NASA.Cassini
                        ivc.title = "Cassini"
                    case "saturn":
                        ivc.imageURL = DemoURL.NASA.Saturn
                        ivc.title = "Saturn"
                    default: break
                }
            }
        }
    }

}

