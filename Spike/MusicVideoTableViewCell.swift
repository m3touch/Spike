//
//  MusicVideoTableViewCell.swift
//  Spike
//
//  Created by Marta Tarragó on 21/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell
{

    var video: Videos?
    {
        // [!!!] Once cell is set from table
        didSet {
            updateCell()
        }
        
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    
    @IBOutlet weak var rank: UILabel!

    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell()
    {
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil
        {
            print("Get data from array...") // It's like I am reusing an already downloaded file
            musicImage.image = UIImage(data: video!.vImageData!)
            
        } else {
            // Download the image
            getVideoImage(video!, imageView: musicImage)
        }
        
        
    }
    
    // Download the image for the cell in  background
    func getVideoImage(video: Videos, imageView: UIImageView)
    {
        // Background thread
        // DISPATCH_QUEUE_PRIORITY_HIGH Items dispatched to the queue will run at high priority, i.e. the queue will be scheduled for execution before any default priority or low priority queue. --> load backend
        //
        // DISPATCH_QUEUE_PRIORITY_DEFAULT Items dispatched to the quque will run at the default priority, i.e. the queue will be scheduled for execution after all high priority quques have been scheduled, but before any low priority queues have been scheduled. --> here
        //
        // DISPATCH_QUEUE_PRIORITY_LOW Items dispatched to the queue will run at low priority, i.e. the queue will be scheduled for execution after all default priority and high priority queues have been scheduled.
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        {
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image : UIImage?
            if data != nil
            {
                // Save the image data
                video.vImageData = data
                // Add to the image view as data, not file
                image = UIImage(data: data!)
            }
            
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue())
            {
                imageView.image = image
            }
                
        }
    }
    
    
    
    
    
    
    
}
