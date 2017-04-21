//
//  LoginViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/12/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 64.0/255.0, green: 153.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    
//    64,153,255

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
    
        TwitterClient.sharedInstance?.login(success: {
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        }) { (error: Error) -> () in
            print(error.localizedDescription)
        }
        
        
        
        
    }


}
