//
//  ViewController.swift
//  Weather
//
//  Created by mwinn on 2/29/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var forcastIOApi = ForcastIOApi.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create views
        // Add views to self
        // Get user current location
        // Setup location manager.
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // Fetch weather from forcastio api using current location
        // Update views with weather data fetched
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        
        let accuracy = lastLocation?.horizontalAccuracy
        print("Recieved location \(lastLocation) with accuracy \(accuracy)")
        
        if (accuracy < 100.0) {
            forcastIOApi.getCurrentLocationWeatherSummary(lastLocation!)
            manager.stopUpdatingLocation()
        }
    }

}

