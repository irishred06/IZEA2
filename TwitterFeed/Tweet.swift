//
//  TWTRTweet.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/14/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import Foundation
import CoreData

@objc(Tweet)
class Tweet : NSManagedObject {
    @NSManaged var tweetId:String?
    @NSManaged var text:String?
    @NSManaged var createdAt:NSDate?
    @NSManaged var author:User?
}

@objc(User)
class User : NSManagedObject {
    @NSManaged var userId:String?
    @NSManaged var name:String?
    @NSManaged var screenName:String?
    @NSManaged var tweets:NSOrderedSet?
}
