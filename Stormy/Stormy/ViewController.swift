//
//  ViewController.swift
//  Stormy
//
//  Created by Eric H on 2/21/15.
//  Copyright (c) 2015 Eric H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let apikey = "2a7636a5544e79525b2bcfb0fee294dd"
        let talEl = "32.928057,35.177280"
        if let forecastURL = NSURL(string: "https://api.forecast.io/forecast/\(apikey)/\(talEl)"){
            let sharedSession = NSURLSession.sharedSession()
            let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(forecastURL, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
                
                let dataObject = NSData(contentsOfURL: location)
                let weatherDataObject = NSJSONSerialization.JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                
                let weather = Current(weatherDictionary: weatherDataObject)
                
                //println(weatherDataObject)
                
            })
            downloadTask.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

