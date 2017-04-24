//
//  ProfileViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/21/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {

    var tweets: [Tweet]!
    
    @IBOutlet weak var profileBannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    
    var user: User? {
        didSet {
            view.layoutIfNeeded()
            
            
            if let name = user?.name {
                nameLabel.text =  name
            }
            if let handle = user?.screenname {
                handleLabel.text =  "@\(handle)"
            }
            if let bio = user?.tagline {
                bioLabel.text = bio
            }
            if let profUrl = user?.profileUrl {
                profileImageView.setImageWith(profUrl)
                profileImageView.clipsToBounds = true
                profileImageView.layer.cornerRadius = 5.0
            }
            
            if let location = user?.location {
                locationLabel.text = location
            }
            
            if let followersCount = user?.followersCount {
                followersCountLabel.text = "\(followersCount)"
            }
            
            if let followingCount = user?.followingCount {
                followingCountLabel.text = "\(followingCount)"
            }
            
            if let backgroundUrl = user?.backgroundImageUrl {
                profileBannerImageView.setImageWith(backgroundUrl)
            }
            
            if let webDisplayUrl = user?.webDisplayUrl {
                webLabel.text = webDisplayUrl
            }
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 250

        grabTweets()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func grabTweets () {
        tweets = []
        let userId = user?.idString ?? ""
        TwitterClient.sharedInstance?.userTimeline(userId: userId, success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
                print("self.tweets.count: \(self.tweets.count)")
            
            self.tweetsTableView.reloadData()
            
        }, failure: { (error: Error) -> () in
            //
        })
        
    }
    

}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        cell.navController = navigationController
        cell.tweet = tweet

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = tweets[indexPath.row]
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TweetDetailViewController") as! TweetDetailViewController
        
        vc.tweet = tweet
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

