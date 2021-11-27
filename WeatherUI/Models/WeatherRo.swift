//
//  WeatherRo.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import Foundation

struct WeatherRo: Codable {
    let current: Weather?
    let hourly: [Weather]?
    let daily: [DailyWeather]?
}
