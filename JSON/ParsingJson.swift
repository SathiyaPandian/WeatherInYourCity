//
//  ParsingJson.swift
//  WeatherInYourCity
//
//  Created by SathiyaSuresh Pandian on 12/12/16.
//  Copyright © 2016 Sathiyasuresh Pandian. All rights reserved.
//

import Foundation
class ParsingJson {
private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/forecast/daily" // daily forecast URL
private let openWeatherMapAPIKey = "376eb8795ff2a33b951deaa6364eaa72" // Weather app developer key
    var objects = [Repository]()
func getWeather(city: String) {
    
    let SearchString = city.replacingOccurrences(of: " ", with:"")
    // configuring URL session, so the shared session will do.
    let session = URLSession(configuration: URLSessionConfiguration.default)
    //  Constructing URL with Key and Query
    let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(SearchString)")! 
    
    // The data task which retrieves the data.
    let dataTask = session.dataTask(with: weatherRequestURL as URL!) {
        (data, response, error) -> Void in
      /*  if let error = error {
            // Case 1: Error
            // We got some kind of error while trying to get data from the server.
            print("Error:\n\(error)")
        }
        else {
            // Case 2: Success
            // We got a response from the server!
            //  print("Data:\n\(data!)")
            let dataString = String(data: data!, encoding: String.Encoding.utf8)
            print("Human-readable data:\n\(dataString!)")// just  printing to make sure the value is received.
            // Due to time constraint the Object mapping for JSON results are not done.
           // self.extract_json_data(data: data! as NSData)
            */
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                let currentConditions = parsedData["list"] as? [NSDictionary]
                
               for item in currentConditions!{
                    print("\(item)")
                self.objects.append(Repository(json: item))
                }
                /*DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.
                }*/
               /*   for item in currentConditions! {
                    // access all key / value pairs in dictionary
                    print("\(value)")
                }
                
                let nestedDictionary = parsedData["list"] as? NSDictionary
                    // access nested dictionary values by key
                print("nest:\(nestedDictionary)")*/
                
                
                //let currentTemperatureF = currentConditions["list"] as! [Array[]:Any]
               // print(currentTemperatureF)
                
            } catch let error as NSError {
                print(error)
            }
        
        }
   // }
    
    // The data task is set up...launch it!
    dataTask.resume()
}
}
