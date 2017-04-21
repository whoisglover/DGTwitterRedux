//
//  Tweet.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/12/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit
import AFNetworking

class Tweet: NSObject {
    
    var text: String?
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var userName: String?
    var profileUrl: URL?
    var screenName: String?
    var isVerified: Bool?
    var timeStampString: String?
    
    init(dictionary: NSDictionary) {
        
        
        let user = dictionary["user"] as! NSDictionary
        let name = user["name"] as? String
        
//        print("user object is: \(user)")
        let profilePictureString = user["profile_image_url_https"] as? String
        
        if let profilePictureString = profilePictureString {
            profileUrl = URL(string: profilePictureString)
        }
        
        
//        let verifiedString = user["verified"] as? String
//        print("user : \(user)")
//        print("ver string: \(verifiedString)")
//        if verifiedString == "1" {
//            isVerified = true
//        } else {
//            isVerified = false
//        }

        
        
        let screenNameText = user["screen_name"] as? String
        screenName = "@\(screenNameText!)"
        
        userName = name
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        var timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString)
        }
        
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .full
        let timeDiff = dateComponentsFormatter.string(from: timeStamp!, to: Date())  // "1 month"
        timeStampString = timeDiff
//        print("time stamp is: \(timeStamp)")
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    
}
