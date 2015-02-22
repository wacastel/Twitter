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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(inputTweet: Tweet) {
        self.tweet = inputTweet
        if let profileImage = self.tweet.user?.profileImageUrl {
            self.profileImageView.setImageWithURL(NSURL(string: profileImage))
        }
        self.userNameLabel.text = self.tweet.user!.name
        self.screenNameLabel.text = "@" + self.tweet.user!.screenname!
        var formatter = NSDateFormatter()
        var timeInterval = -(self.tweet.createdAt!.timeIntervalSinceNow)
        if timeInterval < (24 * 60 * 60) {
            var hours = Int(round((timeInterval) / 3600))
            if hours < 1 {
                hours = 1
            }
            self.timeStampLabel.text = String(hours) + "h"
        } else {
            formatter.dateFormat = "MM/dd/yy"
            self.timeStampLabel.text = formatter.stringFromDate(self.tweet.createdAt!)
        }
        self.tweetTextLabel.text = self.tweet.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetTextLabel.preferredMaxLayoutWidth = self.tweetTextLabel.frame.size.width
    }
    
}
