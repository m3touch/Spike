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
            
            if error != nil {
                // Show the error to the VC
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }
                
            } else {
                // Have data in return
                // print(data)
                
                // For JSONSerialization
                do {
                    /*
                    .AllowFragments - top level object is not Array or Dictionary.
                    Any type of string or value NSJSONSerialization requires the Do / Try / Catch
                    Converts the NSDATA into a JSON Object and cast it to a Disctionary
                    */
                    
                                      // Get data and convert to json object
                    // data! <-- unwrap
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        as? [String: AnyObject] {
                            
                            print(json)
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(result:"JSONSerialization Successful")
                                }
                            }
                            
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "error in NSJSONSerialization")
                    }
                }
            }
        }
        // Execute the task
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}