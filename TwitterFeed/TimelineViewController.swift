//
//  TimelineViewController.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/13/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import Foundation

class TimelineViewController : UITableViewController {

    var credentials:Dictionary<AnyHashable, Any>?
    var request:OAuthIORequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = false
        
        //GET https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=ljarrard&count=2
        
        
        //request!.get(<#T##resource: String!##String!#>, withParams: <#T##Any!#>, success: <#T##RequestSuccessBlock!##RequestSuccessBlock!##([AnyHashable : Any]?, String?, HTTPURLResponse?) -> Void#>)
        
        //request!.get("/1/statuses/user_timeline.json?screen_name=twitterapi&count=2") { (output, body, httpResponse) in
        //    print("REQUEST")
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
