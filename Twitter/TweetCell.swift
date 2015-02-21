//
//  TweetCell.swift
//  Twitter
//
//  Created by William Castellano on 2/20/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width
        //self.userNameLabel.preferredMaxLayoutWidth = self.userNameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(inputTweet: Tweet) {
        self.tweet = inputTweet
        if self.tweet.user?.profileImageUrl != nil {
            self.profileImageView.setImageWithURL(NSURL(string: self.tweet.user!.profileImageUrl!))
        }
        self.userNameLabel.text = self.tweet.user!.name
        self.screenNameLabel.text = self.tweet.user!.screenname
        var formatter = NSDateFormatter()
        self.timeStampLabel.text = formatter.stringFromDate(self.tweet.createdAt!)
        self.tweetTextLabel.text = self.tweet.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width
        //self.userNameLabel.preferredMaxLayoutWidth = self.userNameLabel.frame.size.width
    }
    
}
