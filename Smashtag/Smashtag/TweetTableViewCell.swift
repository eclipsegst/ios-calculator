//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by iOS Students on 5/13/15.
//  Copyright (c) 2015 Zhaolong Zhong. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    func updateUI() {
        // reset any exiting tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        //tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " "
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            // TO DO:
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data:imageData)
                    
                }
            }
//            let formatter = NSDataFormatter()
//            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
//                formatter.dataStyle = NSDateFormatterStyle.ShortStyle
//            } else {
//                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
//            }
        }
        
    }
    
}
