//
//  ImageViewController.swift
//  Cassini
//
//  Created by iOS Students on 5/12/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: NSURL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            let imageData = NSData(contentsOfURL: url)
            if imageData != nil {
                image = UIImage(data: imageData!)
            } else {
                image = nil
            }
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }
    }
    
    // Casuse UIScrollViewDelegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(imageView)
        // put image to scroll view
        scrollView.addSubview(imageView)
//        if image == nil {
//            imageURL = DemoURL.Stanford
//        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    

}
