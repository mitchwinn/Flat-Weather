//
//  ForecastSummary.swift
//  Weather
//
//  Created by mwinn on 3/1/16.
//  Copyright © 2016 Mitch Winn. All rights reserved.
//

import Foundation

// clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, partly-cloudy-night, hail, thunderstorm, tornado
enum WeatherIcon: String {
    case ClearDay = "ClearDay.png"
    case ClearNight = "ClearNight.png"
    case Rain = "Rain.png"
    case Snow = "Snow.png"
    case Sleet = "Sleet.png"
    case Wind = "Wind.png"
    case Fog = "Fog.png"
    case Cloudy = "Cloudy.png"
    case PartlyCloudyDay = "PartlyCloudyDay.png"
    case PartlyCloudyNight = "PartlyCloudyNight.png"
    case Hail = "Hail.png"
    case Thunderstorm = "Thunderstorm.png"
    case Tornado = "Tornado.png"
    case ClearDaySmall = "ClearDaySmall.png"
    case ClearNightSmall = "ClearNightSmall.png"
    case RainSmall = "RainSmall.png"
    case SnowSmall = "SnowSmall.png"
    case SleetSmall = "SleetSmall.png"
    case WindSmall = "WindSmall.png"
    case FogSmall = "FogSmall.png"
    case CloudySmall = "CloudySmall.png"
    case PartlyCloudyDaySmall = "PartlyCloudyDaySmall.png"
    case PartlyCloudyNightSmall = "PartlyCloudyNightSmall.png"
    case HailSmall = "HailSmall.png"
    case ThunderstormSmall = "ThunderstormSmall.png"
    case TornadoSmall = "TornadoSmall.png"
}

struct ForecastSummary {
    var currentTemperature: Double!
    var degreeType: String!
    var weatherIconName: String!
    var nextHourTemperature: Double!
    var nextHourWeatherIconName: String!
    
    init(currentTemperature: Double, weatherIconName: String, nextHourTemperature: Double, nextHourWeatherIconName: String, degreeType: String = "F") {
        self.currentTemperature = currentTemperature
        self.degreeType = degreeType
        self.weatherIconName = self.findWeatherIcon(weatherIconName)
        self.nextHourTemperature = nextHourTemperature
        self.nextHourWeatherIconName = self.findWeatherIcon(nextHourWeatherIconName)
    }
    
    func findWeatherIcon(name: String) -> String {
        switch name {
        case "clear-day":
            return WeatherIcon.ClearDay.rawValue
        case "clear-night":
            return WeatherIcon.ClearNight.rawValue
        case "rain":
            return WeatherIcon.Rain.rawValue
        case "snow":
            return WeatherIcon.Snow.rawValue
        case "sleet":
            return WeatherIcon.Sleet.rawValue
        case "wind":
            return WeatherIcon.Wind.rawValue
        case "fog":
            return WeatherIcon.Fog.rawValue
        case "cloudy":
            return WeatherIcon.Cloudy.rawValue
        case "partly-cloudy-day":
            return WeatherIcon.PartlyCloudyDay.rawValue
        case "partly-cloudy-night":
            return WeatherIcon.PartlyCloudyNight.rawValue
        case "hail":
            return WeatherIcon.Hail.rawValue
        case "thunderstorm":
            return WeatherIcon.Thunderstorm.rawValue
        case "tornado":
            return WeatherIcon.Tornado.rawValue
        default:
            return ""
        }
    }
}
