//
//  ForcastIOApi.swift
//  Weather
//
//  Created by mwinn on 2/29/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import Foundation
import CoreLocation
import ForecastIOClient

struct ForcastIOApi {
    static let sharedInstance = ForcastIOApi()
    private init() {}
    
    func getCurrentLocationWeatherSummary(location: CLLocation, completionBlock:((ForecastSummary)->())?) {
        ForecastIOClient.sharedInstance.forecast(location.coordinate.latitude, longitude: location.coordinate.longitude) { (forecast, forecastAPICalls) -> Void in
            
            // Create new object for the forecast summary
            let forecastSummary = ForecastSummary(currentTemperature: (forecast.currently?.temperature)!,
                                                  weatherIconName: (forecast.currently?.icon)!,
                                                  nextHourTemperature: (forecast.hourly?.data![1].temperature)!,
                                                  nextHourWeatherIconName: (forecast.hourly?.data![1].icon)!)
            
            if (completionBlock != nil) {
                completionBlock!(forecastSummary)
            }
        }
    }
}