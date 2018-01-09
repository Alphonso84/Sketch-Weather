//
//  Model.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//
import Foundation
import UIKit

struct Condition {
    let condition: UIImageView
}
struct Day {
    let temperature: Int
    let conditions: Condition
    let name: String
}

struct Weather {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently
    let minutely: Minutely
    let hourly: Hourly
    let daily: Daily
    let alerts: [Alert]
    let flags: Flags
    let offset: Int
}

struct Minutely {
    let summary, icon: String
    let data: [MinutelyDatum]
}

struct MinutelyDatum {
    let time: Int
    let precipIntensity, precipProbability: Double
    let precipIntensityError: Double?
    let precipType: String?
}

struct Hourly {
    let summary, icon: String
    let data: [HourlyDatum]
}

struct HourlyDatum {
    let time: Int
    let summary, icon: String
    let precipIntensity, precipProbability: Double
    let precipType: String
    let temperature, apparentTemperature, dewPoint, humidity: Double
    let pressure, windSpeed, windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility, ozone: Double
}

struct Flags {
    let sources, isdStations: [String]
    let units: String
}

struct Daily {
    let summary, icon: String
    let data: [DailyDatum]
}

struct DailyDatum {
    let time: Int
    let summary, icon: String
    let sunriseTime, sunsetTime: Int
    let moonPhase, precipIntensity, precipIntensityMax: Double
    let precipIntensityMaxTime: Int
    let precipProbability: Double
    let precipType: String
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windGustTime, windBearing: Int
    let cloudCover: Double
    let uvIndex, uvIndexTime: Int
    let visibility: Double?
    let ozone, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

struct Currently {
    let time: Int
    let summary, icon: String
    let nearestStormDistance, precipIntensity, precipProbability: Int
    let temperature, apparentTemperature, dewPoint, humidity: Double
    let pressure, windSpeed, windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex, visibility: Int
    let ozone: Double
}

struct Alert {
    let title: String
    let regions: [String]
    let severity: String
    let time, expires: Int
    let description, uri: String
}

