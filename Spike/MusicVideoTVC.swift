//
//  MusicVideoTVC.swift
//  Spike
//
//  Created by Marta Tarragó on 21/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
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
    }
    
    
    /// Completion callback when json data is loaded
    func didLoadData(videos: [Videos])
    {
        print(">>>> \(reachabilityStatus)")
        self.videos = videos
        
        for item in videos
        {
            print("name = \(item.vName)")
        }
        
        // Reload the data
        self.tableView.reloadData()
    }
    
    
    /// Changes the screen color switch reachability changes
    func reachabilityStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        //displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
        //displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        //displayLabel.text = "Reachable with Cellular"
        default:return
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Get the video structure information from that index row
        let video = videos[indexPath.row]
        
        // Add the label to the current cell
        cell.textLabel?.text = ("\(indexPath.row+1)")
        
        cell.detailTextLabel?.text = video.vName

        return cell
    }

}
