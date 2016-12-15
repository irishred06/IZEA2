//
//  TimelineViewController.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/13/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TimelineViewController : TWTRTimelineViewController, TWTRTimelineDelegate, ComposeViewControllerDelegate {
    
    @IBOutlet var compose:UIBarButtonItem?
    
    var session:TWTRSession?
    var client:NSObject?
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let managedObjectModel = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.managedObjectModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = false
        
        client = TWTRAPIClient(userID: session!.userName)//TWTRAPIClient()
        
        self.dataSource = TWTRUserTimelineDataSource(screenName: session!.userName, apiClient: client! as! TWTRAPIClient)
        self.timelineDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func composeButtonPressed(button: UIBarButtonItem) {
        let composer = TWTRComposer()
    
        composer.setImage(UIImage(named: "fabric"))
        
        // Called from a UIViewController
        composer.show(from: self) { result in
            if (result == TWTRComposerResult.cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
                self.refresh()
            }
        }
        
        //self.performSegue(withIdentifier: "composePopover", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composePopover" {
            let nav = segue.destination as! UINavigationController
            let composeVC = nav.visibleViewController as! ComposeViewController
            composeVC.delegate = self
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true) {
        }
    }
    
    func timeline(_ timeline: TWTRTimelineViewController, didFinishLoadingTweets tweets: [Any]?, error: Error?) {
        print("timeline")
        
        for tweet in tweets! {
            
            let request = self.managedObjectModel.fetchRequestFromTemplate(withName: "FetchTweetByTweetId", substitutionVariables: ["tweetId":(tweet as! TWTRTweet).tweetID])
            do {
                let array = try self.managedObjectContext.fetch(request!)
                if array.count == 0 {
                    //create a new tweet object
                    let t = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: managedObjectContext) as! Tweet
                    
                    t.createdAt = (tweet as! TWTRTweet).createdAt as NSDate?
                    t.text = (tweet as! TWTRTweet).text as String?
                    t.tweetId = (tweet as! TWTRTweet).tweetID as String?
                    
                    print("new tweet: \(t)")
                    
                    let author = (tweet as! TWTRTweet).author
                    let userId = author.userID as! String
                    
                    let request = self.managedObjectModel.fetchRequestFromTemplate(withName: "FetchUserByUserId", substitutionVariables: ["userId":userId])
                    do {
                        let array = try self.managedObjectContext.fetch(request!)
                        if array.count == 0 {
                            
                            //create a new user object
                            let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as! User
                            user.userId = author.userID
                            user.name = author.name
                            user.screenName = author.screenName
                            
                            t.author = user
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch _ {
                            }
                            
                            print("new user: \(user)")
                        } else {
                            t.author = array[0] as! User
                            print("previous user: \(array[0] as! User)")
                        }
                    } catch _ {
                    }
                } else {
                    print("Tweet already exists")
                }
            } catch _ {
            }
        }   //end for loop
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
    }
}
