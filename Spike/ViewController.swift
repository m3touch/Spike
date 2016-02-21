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
    var videos = [Videos]()

    /// Load json from itunes
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
    
    /// Completion callback when json data is loaded
    func didLoadData(videos: [Videos])
    {
        print(reachabilityStatus)
        
        /*let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            //do something if you want
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)*/
        self.videos = videos
        
        for item in videos
        {
            print("name = \(item.vName)")
        }
        
//        for i in 0..<videos.count
//        {
//            let video = videos[i]
//            print("\(i) name = \(video.vName)")
//        }
        
        for (index, item) in videos.enumerate()
        {
            print("\(index) name = \(item.vName)")
        }
        
        
        
    }

}

