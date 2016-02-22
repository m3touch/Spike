//
//  MusicVideoDetailVC.swift
//  Spike
//
//  Created by Marta Tarragó on 21/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import UIKit

class MusicVideoDetailVC: UIViewController
{

    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vGenere: UILabel!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
    var videos:Videos!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Add the title to the detail
        title = videos.vArtist
        
        // Assing direct information
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenere.text = videos.vGenere
        
        // Check if we have the image there
        if videos.vImageData != nil
        {
            videoImage.image = UIImage(data: videos.vImageData!)
        } else {
            // May be is not there yet -> set the default
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
    }

}
