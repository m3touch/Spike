//
//  ViewController.swift
//  Spike
//
//  Created by Marta Tarragó on 20/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Call download information API
        let api = APIManager()
        
        //OPTION 1:::                                                                /// Callback 2 another func
        api.loadData(kJSON_URL as String, completion:didLoadData)
        
        //OPTION 2::: TRAIL ENCLOSURE
        /*api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
            (result:String) in
            print(result)
        }*/
    
    }
    
    /// Callback
    func didLoadData(result:String)
    {
        //print(result)
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            //do something if you want
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

