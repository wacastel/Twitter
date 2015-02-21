//
//  TweetsViewController.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Plain, target: self, action: "logoutUser")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "composeTweet")
        
        self.title = "Home"
        
        self.navigationItem.titleView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            
            /*for tweet in tweets! {
            println("text: \(tweet.text), created: \(tweet.createdAt)")
            }*/
            
            // home timeline data test
            //var tweet = self.tweets![0] as Tweet
            //println("user's real name: \(tweet.user?.name)")
            //println("user's screen name: \(tweet.user?.screenname)")
            //println("user's profile picture URL: \(tweet.user?.profileImageUrl)")
            //println("text: \(tweet.text)")
            
            //var formatter = NSDateFormatter()
            //var testText = formatter.stringFromDate(tweet.createdAt!)
            //var createdAtText = tweet.createdAtString
            
            //println("createdAt text: \(createdAtText)")
            //println("createdAt NSDate: \(tweet.createdAt)")
            
            // reload table view here
            self.tableView.reloadData()
            
            // Can do "tweet.favorite()" here to do a POST (as opposed to a GET)
            // Add a favorite() function in TwitterClient.swift to implement the 'favorite' API call, etc
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.tweets {
            println("tweets count: \(self.tweets!.count)")
            return self.tweets!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TweetCell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        cell.setTweet(self.tweets![indexPath.row] as Tweet)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let details = TweetDetailViewController(nibName: "TweetDetailViewController", bundle: nil)
        let tweet = self.tweets![indexPath.row] as Tweet
        details.tweet = tweet
        self.navigationController?.pushViewController(details, animated: false)
    }
    
    func logoutUser() {
        User.currentUser?.logout()
    }
    
    func composeTweet() {
        let vc = ComposeViewController(nibName: "ComposeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: false)
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
