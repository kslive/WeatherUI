//
//  DailyWeather.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import Foundation

struct DailyWeather: Codable, Identifiable {
    let dt: Int?
    let temp: Temperature?
    let weather: [WeatherDetail]?
}

extension DailyWeather {
    var id: UUID {
        UUID()
    }
}
