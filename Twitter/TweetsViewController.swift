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
    var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 90
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: UIBarButtonItemStyle.Plain, target: self, action: "logoutUser")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "composeTweet")
        self.title = "Home"
        self.navigationItem.titleView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        self.updateHomeTimeline()
    }
    
    func updateHomeTimeline() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            println("...end refreshing")
        })
    }
    
    func refresh(sender:AnyObject)
    {
        println("refreshing...")
        self.updateHomeTimeline()
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
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    func logoutUser() {
        User.currentUser?.logout()
    }
    
    func composeTweet() {
        let vc = ComposeViewController(nibName: "ComposeViewController", bundle: nil)
        vc.user = User.currentUser
        vc.replyMode = false
        self.navigationController?.pushViewController(vc, animated: true)
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
