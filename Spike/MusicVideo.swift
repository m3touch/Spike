//
//  MusicVideo.swift
//  Spike
//
//  Created by Marta Tarragó on 20/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import Foundation

class Videos
{
    // Data Encapsulation
    private var _vName:String
    private var _vImageUrl:String
    private var _vVideoUrl:String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenere:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    // Getters
    var vName: String { return _vName }
    var vImageUrl: String { return _vImageUrl }
    var vVideoUrl: String { return _vVideoUrl }
    var vRights: String { return _vRights }
    var vPrice: String { return _vPrice }
    var vArtist: String { return _vArtist }
    var vImid: String { return _vImid }
    var vGenere: String { return _vGenere }
    var vLinkToiTunes: String { return _vLinkToiTunes }
    var vReleaseDte: String { return _vReleaseDte }
    
    
    // Initializers
    init (data: JSONDictionary)
    {
        // If we do not initialize all properties we will get error message
        // Return from initializer without initialixing all stored properties
        
        // Video name
        // (if let, else) --> OPTIONAL BINDING
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String
        {
                self._vName = vName
                
        } else {
            // You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            _vName = ""
        }
        
        // The Video Image
        if let img = data["in:image"] as? JSONArray, image = img[2] as? JSONDictionary, immage = image["label"] as? String
        {
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        // Video Url
        if let video = data["link"] as? JSONArray, vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary, vVideoUrl = vHref["href"] as? String
        {
            self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
        // Rights
        if let rights = data["rights"] as? JSONDictionary, vRights = rights["label"] as? String
        {
            _vRights = vRights;
        } else {
            _vRights = ""
        }
        
        // Price
        if let price = data["im:price"] as? JSONDictionary, vPrice = price["label"] as? String
        {
            _vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        // Artist
        if let artist = data["im:artist"] as? JSONDictionary, vArtist = artist["label"] as? String
        {
            _vArtist = vArtist;
        } else {
            _vArtist = ""
        }
        
        // Imid
        if let vId = data["id"] as? JSONDictionary, attrb = vId["attributes"] as? JSONDictionary, vImid = attrb["im:id"] as? String
        {
            _vImid = vImid
        } else {
            _vImid = ""
        }
        
        // Genere
        if let category = data["category"] as? JSONDictionary, attrb = category["category"] as? JSONDictionary,
            vGenere = attrb["label"] as? String
        {
            _vGenere = vGenere
        } else {
            _vGenere = ""
        }
        
        
        // itunes link
        if let category = data["category"] as? JSONDictionary, attrb = category["category"] as? JSONDictionary,
            vLink = attrb["scheme"] as? String
        {
            _vLinkToiTunes = vLink
        } else {
            _vLinkToiTunes = ""
        }
        
        // Release date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary, attrb = releaseDate["attributes"] as? JSONDictionary, date = attrb["label"] as? String
        {
            _vReleaseDte = date
        } else {
            _vReleaseDte = ""
        }
    }
}