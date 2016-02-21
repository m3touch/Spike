//
//  ViewController.swift
//  Spike
//
//  Created by Marta Tarragó on 20/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var videos = [Videos]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    /// Load json from itunes
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Call the network changing observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        // Initialize the screen
        reachabilityStatusChanged()

        // Call download information API
        let api = APIManager()
        //OPTION 1:::           /// Callback 2 another func
        api.loadData(kJSON_URL, completion:didLoadData)
        
        //OPTION 2::: TRIAL ENCLOSURE
        /*api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
            (result:String) in
            print(result)
        }*/
    }
    
    
    /// Completion callback when json data is loaded
    func didLoadData(videos: [Videos])
    {
        print(">>>> \(reachabilityStatus)")
        
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
        
        
        
        // Init table view
        initTableView()
    }
        
    
    /// Changes the screen color switch reachability changes
    func reachabilityStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default:return
        }
    }
    
    /// Is called just as the object is about to be deallocated
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    
    
    
    
    
    
    //MARK: TABLE INITIALIZATION
    func initTableView()
    {
        print("init table data")
        // Takke all the data
        tableView.reloadData()
    }

    
    
    //MARK: TABLE DATA SOURCE PROTOCOLS
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return videos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Reuse identifier for the cell out of screen
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Get the video structure information from that index row
        let video = videos[indexPath.row]
        
        // Add the label to the current cell
        cell.textLabel?.text = ("\(indexPath.row+1)")
        
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    
    
    
    
    
    

}

