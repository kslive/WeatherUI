//
//  Weather.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import Foundation

struct Weather: Codable, Identifiable {
    let dt: Int?
    let temp: Double?
    let feelsLike: Double?
    let humidity: Int?
    let dewPoint: Double?
    let clouds: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let weather: [WeatherDetail]?
}

extension Weather {
    var id: UUID {
        UUID()
    }
}
