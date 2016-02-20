//
//  APIManager.swift
//  Spike
//
//  Created by Marta Tarragó on 20/02/16.
//  Copyright © 2016 m3touch. All rights reserved.
//

import Foundation

class APIManager
{
    /// After loading urlString calls completion that has a result string
    // processes , when done the completion handler to another function that works with the result
    // Void special value, ignored
                                                /// Callback
    func loadData(urlString:String, completion: (result:String) -> Void)
    {
        
        // Uable NSURL caching by configuration
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session =  NSURLSession(configuration: config)
        
        // Singleton ->
        // let session = NSURLSession.sharedSession()
        // Creates an object to a url
        let url = NSURL(string: urlString)! // Makes caching
        
        // Goes out and takes the url and makes an async call to check information
        // Suspended state
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            // Move back to the main thread
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data) // Will print the binary data
                }
            }
        }
        // Execute the task
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}