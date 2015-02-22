//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet!
    var favorited: Bool?
    var tweetId: String!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tweetId = self.tweet.tweetId
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reply", style: UIBarButtonItemStyle.Plain, target: self, action: "reply")
        self.title = "Tweet"
        println("tweet details - real name: \(self.tweet!.user!.name!)")
        println("tweet details - screen name: \(self.tweet!.user!.screenname!)")
        if let profileImage = self.tweet.user?.profileImageUrl {
            self.profileImageView.setImageWithURL(NSURL(string: profileImage))
        }
        self.nameLabel.text = self.tweet!.user!.name!
        self.screenNameLabel.text = "@" + self.tweet!.user!.screenname!
        self.tweetTextLabel.text = self.tweet!.text!
        self.retweetCountLabel.text = String(self.tweet!.retweetCount!)
        self.favoriteCountLabel.text = String(self.tweet!.favoriteCount!)
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy, HH:mm a"
        self.timestampLabel.text = formatter.stringFromDate(self.tweet.createdAt!)
        
        if self.tweet.favorited == 0 {
            self.favoriteButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            self.favorited = false
        } else {
            self.favoriteButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
            self.favorited = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retweet() {
        println("retweet the tweet!")
        println("TweetDetailViewController - tweet id: \(self.tweetId)")
        TwitterClient.sharedInstance.retweet(self.tweetId)
    }
    
    func reply() {
        println("reply to the tweet!")
        let vc = ComposeViewController(nibName: "ComposeViewController", bundle: nil)
        vc.user = User.currentUser
        vc.tweet = self.tweet
        vc.replyMode = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func favorite() {
        if self.favorited == true {
            TwitterClient.sharedInstance.destroyFavorite(self.tweetId)
            self.favorited == false
            self.favoriteButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            println("unfavorited the tweet!")
        } else {
            TwitterClient.sharedInstance.createFavorite(self.tweetId)
            self.favorited == true
            self.favoriteButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
            self.favoriteCountLabel.text = String(self.tweet!.favoriteCount! + 1)
            println("favorited the tweet!")
        }
    }

    @IBAction func onRetweet(sender: AnyObject) {
        self.retweet()
    }
    
    @IBAction func onReply(sender: AnyObject) {
        self.reply()
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        self.favorite()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
