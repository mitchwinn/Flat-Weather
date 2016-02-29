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
    
    func getCurrentLocationWeatherSummary(location: CLLocation) {
        ForecastIOClient.sharedInstance.forecast(location.coordinate.latitude, longitude: location.coordinate.longitude) { (forecast, forecastAPICalls) -> Void in
            // clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, partly-cloudy-night, hail, thunderstorm, tornado
            print(forecast.currently?.summary)
            print(forecast.currently?.temperature)
            print(forecast.currently?.icon)
        }
    }
}