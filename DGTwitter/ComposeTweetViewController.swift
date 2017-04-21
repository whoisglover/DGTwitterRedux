//
//  ComposeTweetViewController.swift
//  DGTwitter
//
//  Created by Danny Glover on 4/17/17.
//  Copyright © 2017 Danny Glover. All rights reserved.
//

import UIKit
import AFNetworking


class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var characterRemainingCount: UILabel!
    
    @IBOutlet weak var sendTweetButton: UIButton!
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cancelImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancelTweet))
        cancelImageView.isUserInteractionEnabled = true
        cancelImageView.addGestureRecognizer(tapGestureRecognizer)
        
        
        let borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1).cgColor
        

        
        tweetTextView.layer.borderColor = borderColor;
        tweetTextView.layer.borderWidth = 1.0;
        tweetTextView.layer.cornerRadius = 5.0;
        
        sendTweetButton.layer.cornerRadius = 5.0
        
        if let userProfUrl = User.currentUser?.profileUrl {
            profileImageView.setImageWith(userProfUrl)
            profileImageView.layer.cornerRadius = 5.0
            profileImageView.clipsToBounds = true
        }
    
    }
    @IBAction func sendTweetPressed(_ sender: Any) {
        print("tweet text: \(tweetTextView.text)")
        TwitterClient.sharedInstance?.sendTweet(message: tweetTextView.text, reply_id: nil, success: { (response: Any) -> () in
            print("success")
            self.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tweetSent"), object: response)
        }, failure: { (error: Error) -> () in
            print("error: \(error.localizedDescription)")
        })
    }
    
    

    func cancelTweet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = range.range(for: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        characterRemainingCount.text = "\(140-changedText.characters.count)"
        return changedText.characters.count < 140
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        tweetTextView.text = ""
        tweetTextView.textColor = UIColor.black
    }
}

extension NSRange {
    func range(for str: String) -> Range<String.Index>? {
        guard location != NSNotFound else { return nil }
        
        guard let fromUTFIndex = str.utf16.index(str.utf16.startIndex, offsetBy: location, limitedBy: str.utf16.endIndex) else { return nil }
        guard let toUTFIndex = str.utf16.index(fromUTFIndex, offsetBy: length, limitedBy: str.utf16.endIndex) else { return nil }
        guard let fromIndex = String.Index(fromUTFIndex, within: str) else { return nil }
        guard let toIndex = String.Index(toUTFIndex, within: str) else { return nil }
        
        return fromIndex ..< toIndex
    }
}

