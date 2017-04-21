//
//  TweetDetailViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/16/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    
    var tweet: Tweet?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweetBody = tweet?.text {
            tweetText.text = tweetBody
        }
        
        if let screenName = tweet?.screenName {
            print("here and screenName: \(screenName)")
            handleLabel.text = screenName
        }
        
        if let retweets = tweet?.retweetCount {
            retweetsLabel.text = "\(retweets) Retweets"
        }
        
        if let favorites = tweet?.favoriteCount {
            likesLabel.text = "\(favorites) Favorites"
        }
        
        nameLabel.text = tweet?.userName
        
        profileImageView.setImageWith((tweet?.profileUrl!)!)
        print("here and tweet is: \(tweet)")
        navigationItem.title = "Tweet"
        
        profileImageView.layer.cornerRadius = 5.0
        
        // Do any additional setup after loading the view.
    }

    


}
