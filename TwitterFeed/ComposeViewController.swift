//
//  ComposeViewController.swift
//  TwitterFeed
//
//  Created by Lauren Jarrard on 12/14/16.
//  Copyright © 2016 Lauren Jarrard. All rights reserved.
//

import Foundation
import UIKit

protocol ComposeViewControllerDelegate {
    func dismiss()
}

class ComposeViewController : UIViewController {
    @IBOutlet var cancel:UIBarButtonItem?
    @IBOutlet var submit:UIButton?
    @IBOutlet var text:UITextView?
    
    var delegate:ComposeViewControllerDelegate?
    
    @IBAction func cancelButtonPressed(button: UIBarButtonItem) {
        delegate?.dismiss()
    }
    
    @IBAction func submitButtonPressed(button: UIButton) {
        //Try to contact twitter

        
        delegate?.dismiss()
    }
}
