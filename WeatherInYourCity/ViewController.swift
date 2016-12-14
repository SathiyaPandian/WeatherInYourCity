//
//  ViewController.swift
//  WeatherInYourCity
//
//  Created by SathiyaSuresh Pandian on 12/12/16.
//  Copyright © 2016 Sathiyasuresh Pandian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource  {
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/forecast/daily" // daily forecast URL
    private let openWeatherMapAPIKey = "376eb8795ff2a33b951deaa6364eaa72" // Weather app developer key
    var objects = [Repository]()
    let klevinConst = 273.15 // kelvin constant used to convert weather temperatures into celsius
    @IBOutlet weak var wc_TableView: UITableView!
    @IBOutlet weak var wc_SearchBar: UISearchBar!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.wc_TableView.dataSource = self
        self.wc_TableView.delegate = self
        if let name = defaults.string(forKey:"locationKey") {
            // Method to get the weather forecast
            getWeather(city:name)
            wc_SearchBar.text = name // loading the city name on next launch

        }
        wc_TableView.tableFooterView = UIView() // to hide blank / empty cells in table view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count //json object count.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "WcTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! WcTableviewCell!
        if cell == nil {
            cell = WcTableviewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        // date conversion
        let date = NSDate(timeIntervalSince1970: self.objects[indexPath.row].dt!)
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "E MMM d" // format to show day, month and date
        let dateString                 = dateFormatter.string(from: date as Date)
       // weather icon URL
        let imgURL = "http://openweathermap.org/img/w/\(self.objects[indexPath.row].icon!).png"
        
        var image: UIImage?
        if let myImageData = NSData(contentsOf: NSURL(string:imgURL)! as URL) {
            image =  UIImage(data: myImageData as Data)
        }
        // Clouds percent symbol
        let cloudsValue = String(format:"clouds: %.0f",self.objects[indexPath.row].clouds!)
        cell?.degTempTableView?.text = self.objects[indexPath.row].description
        cell?.minTempTableView?.text =  String(format:"%.1f °C", self.objects[indexPath.row].min! - self.klevinConst)
        cell?.maxTempTableView?.text = String(format:"%.1f °C", self.objects[indexPath.row].max! - self.klevinConst)
        cell?.dateTableViewCell?.text = dateString
        cell?.imgWcTableviewCell?.image = image
        cell?.cloudsTableViewCell?.text = "\(cloudsValue)%"
        cell?.speedTableViewCell?.text = String(format:"%.1f m/s",self.objects[indexPath.row].speed!)
            
        return cell!
    }
    
// Mark: Search Delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // dismiss the keyboard
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
           getWeather(city: searchText)
            defaults.set(searchText, forKey: "locationKey") // Setting the value in user defaults to load on next launch
        }
        
    }
// Mark: JSON Parsing
    /* Planning to implement JSON parsing in a new class and retieve the values here, couldn't finish since ParsingJSON.swift file needs some more time and attention*/
    func getWeather(city: String) {
        
        let SearchString = city.replacingOccurrences(of: " ", with:"")
        // configuring URL session, so the shared session will do.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //  Constructing URL with Key and Query
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(SearchString)")!
        
        // The data task which retrieves the data.
        let dataTask = session.dataTask(with: weatherRequestURL as URL!) {
            (data, response, error) -> Void in
            do {
                
                let parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                let currentConditions = parsedData["list"] as? [NSDictionary]
                
                self.objects.removeAll()
                
                for item in currentConditions!{
                    print("Item:\(item)")
                    self.objects.append(Repository(json: item)) // assigning values to JSON Model
                    }
                DispatchQueue.main.async( execute: {
                    self.wc_TableView.reloadData()
                })
                
            } catch let error as NSError {
                print(error)
            }
            
        }
        // }
        
        // The data task is set up...launch it!
        dataTask.resume()
    }
    
    
}

