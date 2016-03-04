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
    //MARK: - Instance Variables.
    var locationManager: CLLocationManager!
    var forcastIOApi = ForcastIOApi.sharedInstance
    
    //MARK: Interface Builder Variables.
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentForecastSummary: UILabel!
    @IBOutlet weak var nextHourTempLabel: UILabel!
    @IBOutlet weak var nextHourWeatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update views.
        cardView.layer.cornerRadius = 5.0
        updateWeatherView(75, currentWeatherIcon: "Rain", currentForecastSummary: "Light rain for now :(", nextHourTemp: 75, nextHourWeatherIcon: "CloudySmall")
        
        // Setup location manager.
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
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
            forcastIOApi.getCurrentLocationWeatherSummary(lastLocation!, completionBlock: {
                (let forecastSummary: ForecastSummary) in
                // Update UI with forecastSummary data.
                self.updateWeatherView(Int(forecastSummary.currentTemperature), currentWeatherIcon: forecastSummary.weatherIconName, currentForecastSummary: forecastSummary.forecastSummary, nextHourTemp: Int(forecastSummary.nextHourTemperature), nextHourWeatherIcon: forecastSummary.nextHourWeatherIconName)
            })
            manager.stopUpdatingLocation()
        }
    }
    
    func updateWeatherView(currentTemp: Int, currentWeatherIcon: String, currentForecastSummary: String,
        nextHourTemp: Int, nextHourWeatherIcon: String) {
        self.currentTempLabel.text = "\(currentTemp)F"
        self.weatherIconImageView.image = UIImage(named: currentWeatherIcon)
        // x 96 y 109
        self.weatherIconImageView.frame = CGRectMake((self.cardView.frame.width / 2) - ((UIImage(named: currentWeatherIcon)?.size.width)! / 2), 109, (UIImage(named: currentWeatherIcon)?.size.width)!, (UIImage(named: currentWeatherIcon)?.size.height)!)
        self.currentForecastSummary.text = currentForecastSummary
        self.nextHourTempLabel.text = "\(nextHourTemp)F"
        self.nextHourWeatherIcon.image = UIImage(named: nextHourWeatherIcon)
            
        switch currentWeatherIcon {
        case "ClearDay",
             "PartlyCloudyDay":
            self.cardView.backgroundColor = UIColor(red: 255/255, green: 137/255, blue: 0.0, alpha: 1.0)
        default:
            self.cardView.backgroundColor = UIColor(red: 131/255, green: 177/255, blue: 196/255, alpha: 1.0)
        }
    }
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        self.locationManager.startUpdatingLocation()
    }
}

