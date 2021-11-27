//
//  API+Extensions.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import Foundation

extension API {
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    static func getUrlFor(lat: Double, lon: Double) -> String {
        "\(baseUrl)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely$appid=\(key)&units=metric"
    }
}
