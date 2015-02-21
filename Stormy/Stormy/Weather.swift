//
//  Weather.swift
//  Stormy
//
//  Created by Eric H on 2/16/15.
//  Copyright (c) 2015 Eric H. All rights reserved.
//

import Foundation
import UIKit

struct Current {

    var temperature: Int?
    var humidity: Int
    var icon: UIImage
    var dateTime: String
    var windSpeedInMilesPerHour: Double
    var summary: String

    init(weatherDictionary: NSDictionary){
//        currently =     {
//            apparentTemperature = "41.63";
//            cloudCover = "0.46";
//            dewPoint = "38.61";
//            humidity = "0.6899999999999999";
//            icon = rain;
//            ozone = "344.94";
//            precipIntensity = "0.0089";
//            precipProbability = "0.44";
//            precipType = rain;
//            pressure = "1016.51";
//            summary = "Drizzle and Breezy";
//            temperature = "48.21";
//            time = 1424294845;
//            windBearing = 254;
//            windSpeed = "18.12";
//        };
        
        let weather = weatherDictionary["currently"] as NSDictionary
        
        humidity = weather["humidity"] as Int
        
        let iconName = weather["icon"] as String
        icon = UIImage(named: iconName)!
     
        let intervalTime = NSTimeInterval(weather["time"] as Int)
        let dateSince1970 = NSDate(timeIntervalSince1970: intervalTime)
    
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        dateTime = dateFormatter.stringFromDate(dateSince1970) as String!
        
        windSpeedInMilesPerHour = weather["windSpeed"] as Double
        summary = weather["summary"] as String
        
        var temperatureInFahrenheit = weather["temperature"] as Int
        temperature = fahrenheitToCelsuis(temperatureInFahrenheit) as Int!
    }
    
    func fahrenheitToCelsuis (fahrenheit: Int) -> Int{
        // [°C] = ([°F] - 32) × 5/9
        return (fahrenheit - 32) * (5 / 9)
    }
}
   