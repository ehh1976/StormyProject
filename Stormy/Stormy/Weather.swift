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
    var windSpeed: String!
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
        //dateFormatter.timeStyle = .MediumStyle
        //dateFormatter.dateStyle = .ShortStyle
        //dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC+2.00")
        //func ltzAbbrev() -> String { return NSTimeZone.systemTimeZone().abbreviation! }
        //func ltzName() -> String { return NSTimeZone.systemTimeZone().name }
        //dateFormatter.timeZone = NSTimeZone(abbreviation: ltzAbbrev())
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        dateTime = dateFormatter.stringFromDate(dateSince1970) as String!

        summary = weather["summary"] as String
        
        
        let windSpeedInMilesPerHour = weather["windSpeed"] as Double
        windSpeed = NSString(format: "%.2f", (mphTokmh(windSpeedInMilesPerHour))) + " km/h"
                
        var temperatureInFahrenheit = weather["temperature"] as Int
        temperature = fahrenheitToCelsuis(temperatureInFahrenheit) as Int
    }
    
    func fahrenheitToCelsuis (fahrenheit: Int) -> Int{
        // [°C] = ([°F] - 32) × 5/9
        let celsuis = Int((Double(fahrenheit) - 32.0) * (5.0 / 9.0))
        return celsuis
    }
    
    func mphTokmh (mph: Double)-> Double {
        let kmh = mph*1.6903
        return kmh
    }
}
   