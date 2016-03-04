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
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update views.
        cardView.layer.cornerRadius = 5.0
        self.startSpinningAnnimation()
        updateWeatherView(75, currentWeatherIcon: "Rain", currentForecastSummary: "Loading...", nextHourTemp: 75, nextHourWeatherIcon: "CloudySmall")
        
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
                self.updateWeatherView(Int(forecastSummary.currentTemperature),
                                           currentWeatherIcon: forecastSummary.weatherIconName,
                                           currentForecastSummary: forecastSummary.forecastSummary,
                                           nextHourTemp: Int(forecastSummary.nextHourTemperature),
                                           nextHourWeatherIcon: forecastSummary.nextHourWeatherIconName)
                self.stopSpinningAnnimation()
            })
            manager.stopUpdatingLocation()
        }
    }
    
    func startSpinningAnnimation() {
        // create a spin animation
        let spinAnimation = CABasicAnimation()
        // starts from 0
        spinAnimation.fromValue = 0
        // goes to 360 ( 2 * π )
        spinAnimation.toValue = M_PI*2
        // define how long it will take to complete a 360
        spinAnimation.duration = 1
        // make it spin infinitely
        spinAnimation.repeatCount = Float.infinity
        // do not remove when completed
        spinAnimation.removedOnCompletion = false
        // specify the fill mode
        spinAnimation.fillMode = kCAFillModeForwards
        // and the animation acceleration
        spinAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        // add the animation to the button layer
        self.refreshButton.layer.addAnimation(spinAnimation, forKey: "transform.rotation.z")
    }
    
    func stopSpinningAnnimation() {
        // remove the animation
        self.refreshButton.layer.removeAllAnimations()
    }
    
    func updateWeatherView(currentTemp: Int, currentWeatherIcon: String, currentForecastSummary: String, nextHourTemp: Int, nextHourWeatherIcon: String) {
        let weatherIconImage = UIImage(named: currentWeatherIcon)
        self.currentTempLabel.text = "\(currentTemp)F"
        self.weatherIconImageView.image = weatherIconImage
        // Image should be around x: ~96 y: 109
        self.weatherIconImageView.frame = CGRectMake((self.cardView.frame.width / 2) - (weatherIconImage!.size.width / 2),
                                                     109,
                                                     weatherIconImage!.size.width,
                                                     weatherIconImage!.size.height)
        self.currentForecastSummary.text = currentForecastSummary
        self.nextHourTempLabel.text = "\(nextHourTemp)F"
        self.nextHourWeatherIcon.image = UIImage(named: nextHourWeatherIcon)
            
        switch currentWeatherIcon {
        case "ClearDay",
             "PartlyCloudyDay":
            // Burnt Orange
            self.cardView.backgroundColor = UIColor(red: 255/255, green: 137/255, blue: 0.0, alpha: 1.0)
        default:
            // Rainy Blue
            self.cardView.backgroundColor = UIColor(red: 131/255, green: 177/255, blue: 196/255, alpha: 1.0)
        }
    }
    
    @IBAction func refreshButtonTapped(sender: AnyObject) {
        self.startSpinningAnnimation()
        self.locationManager.startUpdatingLocation()
    }
}

