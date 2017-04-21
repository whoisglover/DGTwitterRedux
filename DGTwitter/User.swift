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
        
        tagline = dictionary["description"] as? String
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
