//
//  TweetCell.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/13/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var repliesLabel: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    
    @IBOutlet weak var favoritesLabel: UILabel!
    
    
    var tweet: Tweet? {
        didSet {
            tweetTextLabel.text = tweet?.text
            usernameLabel.text = tweet?.userName
            
            retweetsLabel.text = "\(tweet?.retweetCount ?? 0)"
            favoritesLabel.text = "\(tweet?.favoriteCount ?? 0)"
            
            profileImageView.setImageWith((tweet?.profileUrl!)!)
            profileImageView.layer.cornerRadius = 4
            handleLabel.text = tweet?.screenName
            
            if let verifiedStatus = tweet?.isVerified {
                print("verified status: \(verifiedStatus)")
                if verifiedStatus == false {
                    verifiedImageView.isHidden = true
                }
            }
            if let timeStamp = tweet?.timeStampString {
                
                timestampLabel.text = timeStamp
            }
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
