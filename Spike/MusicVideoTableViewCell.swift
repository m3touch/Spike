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
        musicImage.image = UIImage(named: "imageNotAvailable")
    }
    
}
