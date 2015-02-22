//
//  Tweet.swift
//  Twitter
//
//  Created by William Castellano on 2/18/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favoriteCount: Int?
    var favorited: Int?
    var retweeted: Int?
    var tweetId: String?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Int
        retweeted = dictionary["retweeted"] as? Int
        createdAtString = dictionary["created_at"] as? String
        tweetId = String(dictionary["id"] as Int!)
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}
