//
//  ViewController.swift
//  Stormy
//
//  Created by Eric H on 2/21/15.
//  Copyright (c) 2015 Eric H. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!

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
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.temperatureLabel.text = "\(weather.temperature!)"
                    self.humidityLabel.text = "\(weather.humidity)"
                    self.windSpeedLabel.text = "\(weather.windSpeed!)"
                    self.descriptionLabel.text = "\(weather.summary)"
                    self.timeLabel.text = "\(weather.dateTime)"
                    self.locationLabel.text = "Tal-El, Israel"
                    self.iconImage.image = weather.icon                    
                })
            })
            downloadTask.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

