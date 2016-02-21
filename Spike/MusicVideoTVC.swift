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
        
        
    }
    
    
    /// Changes the screen color switch reachability changes
    func reachabilityStatusChanged()
    {
        switch reachabilityStatus {
        case NOACCESS :
            
            //view.backgroundColor = UIColor.redColor()
            
            // move back to Main Queue (avoid presenting alert before the view has been loaded)
            dispatch_async(dispatch_get_main_queue()){
            
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            
                let cancelAction = UIAlertAction(title: "Cancel", style: .Default){
                    action -> () in
                    print("Cancel")
                }
            
                let deleteAction = UIAlertAction(title: "Delete", style: .Destructive){
                    action -> () in
                    print("delete")
                }
            
                let okAction = UIAlertAction(title: "OK", style: .Default) {
                    action -> Void in
                    print("ok")
                
                    //do something if you want
                    //alert.dismissViewControllerAnimated(true, completion:nil)
                }
        
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
            
                self.presentViewController(alert, animated: true, completion: nil)
            }
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0
            {
                print("do not refresh API")
            } else {
                runAPI()
            }
        }
    }
    
    func runAPI()
    {
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
            print("img = \(item.vImageUrl)")
        }
        
        // Init table view
        self.tableView.reloadData()
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
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

    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

        // Set the video information to the cell
        cell.video = videos[indexPath.row]
        
        

        return cell
    }

}
