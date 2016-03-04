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
    case ClearDay = "ClearDay"
    case ClearNight = "ClearNight"
    case Rain = "Rain"
    case Snow = "Snow"
    case Sleet = "Sleet"
    case Wind = "Wind"
    case Fog = "Fog"
    case Cloudy = "Cloudy"
    case PartlyCloudyDay = "PartlyCloudyDay"
    case PartlyCloudyNight = "PartlyCloudyNight"
    case Hail = "Hail"
    case Thunderstorm = "Thunderstorm"
    case Tornado = "Tornado"
    case ClearDaySmall = "ClearDaySmall"
    case ClearNightSmall = "ClearNightSmall"
    case RainSmall = "RainSmall"
    case SnowSmall = "SnowSmall"
    case SleetSmall = "SleetSmall"
    case WindSmall = "WindSmall"
    case FogSmall = "FogSmall"
    case CloudySmall = "CloudySmall"
    case PartlyCloudyDaySmall = "PartlyCloudyDaySmall"
    case PartlyCloudyNightSmall = "PartlyCloudyNightSmall"
    case HailSmall = "HailSmall"
    case ThunderstormSmall = "ThunderstormSmall"
    case TornadoSmall = "TornadoSmall"
}

struct ForecastSummary {
    var currentTemperature: Double!
    var degreeType: String!
    var weatherIconName: String!
    var nextHourTemperature: Double!
    var nextHourWeatherIconName: String!
    var forecastSummary: String!
    
    init(currentTemperature: Double, weatherIconName: String, nextHourTemperature: Double, nextHourWeatherIconName: String, summary: String, degreeType: String = "F") {
        self.currentTemperature = currentTemperature
        self.degreeType = degreeType
        self.weatherIconName = self.findWeatherIcon(weatherIconName)
        self.nextHourTemperature = nextHourTemperature
        self.nextHourWeatherIconName = self.findWeatherIcon(nextHourWeatherIconName)
        self.forecastSummary = summary
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
