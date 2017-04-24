//
//  MenuViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/20/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var menuTableView: UITableView!
    
    private var mentionsNavigationController: UIViewController!
    private var selfProfileViewController: ProfileViewController!
    private var tweetsNavigationController: UIViewController!
    
    
    var viewControllers: [UIViewController] = []
    
    var hamburgerViewController: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        selfProfileViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        selfProfileViewController.user = User.currentUser
        
        mentionsNavigationController = storyBoard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        tweetsNavigationController = storyBoard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        
        viewControllers.append(selfProfileViewController)
        viewControllers.append(mentionsNavigationController)
        viewControllers.append(tweetsNavigationController)
        
        
        hamburgerViewController.contentViewController = tweetsNavigationController
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = ["Profile", "Mentions", "Timeline"]
        
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        cell.menuTitleLabel.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuTableView.deselectRow(at: indexPath, animated: true)
        
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        
    }
    
    

}
