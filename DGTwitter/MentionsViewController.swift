//
//  MentionsViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/13/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {
    
    var tweets: [Tweet]!
    let refreshControl = UIRefreshControl.init()
    
    @IBOutlet weak var tweetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        
        let icon = UIImage(named: "birdBlue")
        let birdImageView = UIImageView(image: icon)
        navigationItem.titleView = birdImageView
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: "titleWasTapped")
        
        birdImageView.isUserInteractionEnabled = true
        birdImageView.addGestureRecognizer(recognizer)
        
        
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(TweetsViewController.grabTweets), for: UIControlEvents.valueChanged)
        tweetsTableView.addSubview(refreshControl)
        
        
        grabTweets()
        
        
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        tweetsTableView.estimatedRowHeight = 250
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "tweetSent"), object: nil, queue: OperationQueue.main, using: {
            (Notification) -> Void in
            let tweetObject = Notification.object as! NSDictionary
            let tweet = Tweet(dictionary: tweetObject)
            self.tweets.insert(tweet, at: 0)
            self.tweetsTableView.reloadSections([0], with: .automatic)
        })
        
    }
    
    func titleWasTapped() {
        tweetsTableView.setContentOffset(CGPoint.zero, animated: true)
    }
    @IBAction func onLogoutButton(_ sender: Any) {
        print("logout button pressed")
        TwitterClient.sharedInstance?.logout()
    }
    
    func grabTweets () {
        tweets = []
        TwitterClient.sharedInstance?.mentionTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetsTableView.reloadData()
            self.refreshControl.endRefreshing()
            
            
        }, failure: { (error: Error) -> () in
            //
        })
        
    }
}

extension MentionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        if(!refreshControl.isRefreshing) {
            let tweet = tweets[indexPath.row]
            cell.tweet = tweet
        }
        cell.navController = navigationController
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
