//
//  JSONmodel.swift
//  WeatherInYourCity
//
//  Created by SathiyaSuresh Pandian on 12/13/16.
//  Copyright © 2016 Sathiyasuresh Pandian. All rights reserved.
//

import Foundation
// JSON Object Model construction to store the values and utilize the same. 
class Repository {
    var clouds: Double?
    var deg: String?
    var dt: Double?
    var humidity: String?
    var pressure: String?
    var rain: String?
    var speed: Double?
    var temp: NSDictionary
    var day: Double?
    var eve: Double?
    var max: Double?
    var min: Double?
    var morn: Double?
    var night: Double?
    var weather: [NSDictionary]
    var description: String?
    var icon: String?
    var id: String?
    var main: String?
    
    
    init(json:NSDictionary) {
        self.clouds = json["clouds"] as? Double
        self.deg = json["deg"] as? String
        self.dt = json["dt"] as? Double
        self.humidity = json["humidity"] as? String
        self.pressure = json["pressure"] as? String
        self.rain = json["rain"] as? String
        self.speed = json["speed"] as? Double
        self.temp = (json["temp"] as? NSDictionary)!
        self.day = json["day"] as? Double
        self.eve = json["eve"] as? Double
        self.max = temp["max"] as? Double
        self.min = temp["min"] as? Double
        self.morn = json["morn"] as? Double
        self.night = json["night"] as? Double
        self.weather = (json["weather"] as? [NSDictionary])!
        self.description = weather[0]["description"] as? String
        self.icon = weather[0]["icon"] as? String
        self.id = json["id"] as? String
        self.main = json["main"] as? String
    }
    
}
