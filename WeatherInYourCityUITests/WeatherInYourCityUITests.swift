//
//  WeatherInYourCityUITests.swift
//  WeatherInYourCityUITests
//
//  Created by SathiyaSuresh Pandian on 12/12/16.
//  Copyright © 2016 Sathiyasuresh Pandian. All rights reserved.
//

import XCTest
@testable import WeatherInYourCity

class WeatherInYourCityUITests: XCTestCase {
        var vc: ViewController!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        vc = storyboard.instantiateInitialViewController() as! ViewController

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       // let cityName = vc.defaults.string(forKey:"locationKey")
        let jsonCityName = vc.wc_SearchBar.text
        XCTAssertNotNil(jsonCityName, "Search text shouldn't be blank")
    }
    func testRepository() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
       
        if (vc.objects.count > 0){
            print("Objects count is zero")
        }
        XCTAssertNotNil(vc.objects.count, "Objects count should be greater than 1")
    }
    func testUserDefaults() {
        let cityName = vc.defaults.string(forKey:"locationKey")
        XCTAssertNotNil(cityName, "City namestored in userdefaults shouldn't be blank")
    }
    func testComparsion() {
         let cityName = vc.defaults.string(forKey:"locationKey")
         let jsonCityName = vc.wc_SearchBar.text
        XCTAssertEqual(cityName, jsonCityName)
    }

}
