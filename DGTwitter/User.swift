//
//  User.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/12/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    var followersCount: Int?
    var followingCount: Int?
    var location: String?
    var backgroundImageUrl: URL?
    var idString: String?
    var webDisplayUrl: String?
    
    var dictionary: NSDictionary?
    
    static let userDidLogOutNotification = "UserDidLogout"
    
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundImageUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundImageUrlString = backgroundImageUrlString {
            backgroundImageUrl = URL(string: backgroundImageUrlString)
        }
        
        tagline = dictionary["description"] as? String
        
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        
        location = dictionary["location"] as? String

        idString = dictionary["id_str"] as? String
        
        
        if let webURL = dictionary["entities"] as? NSDictionary{
            if let urlsTop = webURL["url"] as? NSDictionary {
                if let urlsArray = urlsTop["urls"] as? NSArray {
                    if let urlObject = urlsArray[0] as? NSDictionary {
                        if let webString = urlObject["display_url"] as? String {
                            webDisplayUrl = webString
                        }
                    }
                }
            }
        }
//        print(name)
        
        
//        print(screenname)
//        print(profileUrl)
//        print(tagline)
//        print(followersCount)
//        print(followingCount)
//        print(location)
        
        
        
    }
    
    static var _currentUser: User?
    
    static var currentUser: User? {
        get {
            if (_currentUser == nil) {
                let defaults = UserDefaults.standard
                let data = defaults.object(forKey: "currentUserData") as? Data
                
                if let data = data {
                    
                    let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    if let dictionary = dictionary {
                        _currentUser = User(dictionary: dictionary)
                    }
                } else {
                    print("defaults data fetch or unwrap failed")
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
        
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
                let saved = defaults.object(forKey: "currentUser") as? Data
            } else {
                print("about to set user nil in nsuserdefaults from currentUser setter")
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }

}
