//
//  TwitterClient.swift
//  Twitter
//
//  Created by William Castellano on 2/18/15.
//  Copyright (c) 2015 William Castellano. All rights reserved.
//

import UIKit

let twitterConsumerKey = "eAlhb1LdTz0WyPuzI83gjVFlP"
let twitterConsumerSecret = "pZ90InluWVYrNVGPfvdeuNIRjfmkjVOhlieKm0nxEQ4X6S1iBn"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var LoginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println("home timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            /*for tweet in tweets {
                println("text: \(tweet.text), created: \(tweet.createdAt)")
            }*/
            completion(tweets: tweets, error: nil)
            
        }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Error getting home timeline")
            completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        LoginCompletion = completion
        
        // Fetch request token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error: NSError!) -> Void in
            println("Failed to get request token")
            self.LoginCompletion?(user: nil, error: error)
        }
    }
    
    func updateStatus(params: NSDictionary?) {
        POST("1.1/statuses/update.json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Sent tweet successfully! Response: \(response)")
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Error sending tweet: \(error)")
        }
    }
    
    func retweet(tweetId: String) {
        var params: NSDictionary = ["id": tweetId]
        println("TwitterClient - tweet id: \(tweetId)")
        POST("1.1/statuses/retweet/:\(tweetId).json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Retweeted tweet successfully! Response: \(response)")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error retweeting tweet: \(error)")
        }
    }
    
    func createFavorite(tweetId: String) {
        var params: NSDictionary = ["id": tweetId]
        println("TwitterClient/createFavorite - tweet id: \(tweetId)")
        POST("1.1/favorites/create.json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Favorited tweet successfully! Response: \(response)")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error creating favorite: \(error)")
        }
    }
    
    func destroyFavorite(tweetId: String) {
        var params: NSDictionary = ["id": tweetId]
        println("TwitterClient/destroyFavorite - tweet id: \(tweetId)")
        POST("1.1/favorites/destroy.json", parameters: params, success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("Unfavorited tweet successfully! Response: \(response)")
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error destroying favorite: \(error)")
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("user: \(response)")
                var user = User(dictionary: response as NSDictionary)
                User.currentUser = user
                println("user: \(user.name)")
                self.LoginCompletion?(user: user, error: nil)
                
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("Error getting current user")
                self.LoginCompletion?(user: nil, error: error)
            })
            
            
        }) { (error: NSError!) -> Void in
            println("Failed to receive access token")
            self.LoginCompletion?(user: nil, error: error)
        }
    }
}
