//
//  CityViewModel.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI
import CoreLocation

final class CityViewModel: ObservableObject {
    @Published var weather = WeatherRo(current: nil, hourly: [], daily: [])
    @Published var city = "Moscow" {
        didSet {
             getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    var date: String {
        dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current?.dt ?? 0)))
    }
    var weatherIcon: String {
        guard let weather = weather.current?.weather, !weather.isEmpty else { return "sun.max.fill" }
        return weather[0].icon ?? "sun.max.fill"
    }
    var temperature: String {
        guard let temp = weather.current?.temp else { return "" }
        return getTempFor(temp: temp)
    }
    var conditions: String {
        guard let weather = weather.current?.weather, !weather.isEmpty else { return "" }
        return weather[0].main ?? ""
    }
    var windSpeed: String {
        guard let speed = weather.current?.windSpeed else { return "" }
        return .init(format: "%0.1f", speed)
    }
    var humidity: String {
        guard let humidity = weather.current?.humidity else { return "" }
        return .init(format: "%d%%", humidity)
    }
    var rainChainces: String {
        guard let rainChainces = weather.current?.dewPoint else { return "" }
        return String(format: "%0.0f%%", rainChainces)
    }
    
    init() {
         getLocation()
    }
    
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
            case "01d":
                return "dayClearSky"
            case "01n":
                return "nightClearSky"
            case "02d":
                return "dayFewClouds"
            case "02n":
                return "nightFewClouds"
            case "03d":
                return "dayScatteredClouds"
            case "03n":
                return "nightScatteredClouds"
            case "04d":
                return "dayBrokenClouds"
            case "04n":
                return "nightBrokenClouds"
            case "09d":
                return "dayShowerRains"
            case "09n":
                return "nightShowerRains"
            case "10d":
                return "dayRain"
            case "10n":
                return "nightRain"
            case "11d":
                return "dayThunderstorm"
            case "11n":
                return "nightThunderstorm"
            case "13d":
                return "daySnow"
            case "13n":
                return "nightSnow"
            case "50d":
                return "dayMist"
            case "50n":
                return "dayMist"
            default:
                return "dayClearSky"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
            case "01d":
                return Image(systemName: "sun.max.fill") //"clear_sky_day"
            case "01n":
                return Image(systemName: "moon.fill") //"clear_sky_night"
            case "02d":
                return Image(systemName: "cloud.sun.fill") //"few_clouds_day"
            case "02n":
                return Image(systemName: "cloud.moon.fill") //"few_clouds_night"
            case "03d":
                return Image(systemName: "cloud.fill") //"scattered_clouds"
            case "03n":
                return Image(systemName: "cloud.fill") //"scattered_clouds"
            case "04d":
                return Image(systemName: "cloud.fill") //"broken_clouds"
            case "04n":
                return Image(systemName: "cloud.fill") //"broken_clouds"
            case "09d":
                return Image(systemName: "cloud.drizzle.fill") //"shower_rain"
            case "09n":
                return Image(systemName: "cloud.drizzle.fill") //"shower_rain"
            case "10d":
                return Image(systemName: "cloud.heavyrain.fill")//"rain_day"
            case "10n":
                return Image(systemName: "cloud.heavyrain.fill") //"rain_night"
            case "11d":
                return Image(systemName: "cloud.bolt.fill") //"thunderstorm_day"
            case "11n":
                return Image(systemName: "cloud.bolt.fill") //"thunderstorm_night"
            case "13d":
                return Image(systemName: "cloud.snow.fill") //"snow"
            case "13n":
                return Image(systemName: "cloud.snow.fill") //"snow"
            case "50d":
                return Image(systemName: "cloud.fog.fill") //"mist"
            case "50n":
                return Image(systemName: "cloud.fog.fill") //"mist"
            default:
                return Image(systemName: "sun.max.fill")
        }
    }
    
    private func getTimeFor(timestamp: Int) -> String {
        timeFormatter.string(from: .init(timeIntervalSince1970: .init(timestamp)))
    }
    
    private func getTempFor(temp: Double) -> String {
        .init(format: "%0.1f", temp)
    }
    
    private func getDayFor(timestamp: Int) -> String {
        dayFormatter.string(from: .init(timeIntervalSince1970: .init(timestamp)))
    }
    
    // MARK: - API
    
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { [weak self] placemarks, _ in
            guard let self = self, let places = placemarks, let place = places.first else { return }
            self.getWeather(coordinate: place.location?.coordinate)
        }
    }
    
    private func getWeather(coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate,
              let url = URL(string: API.getUrlFor(lat: coordinate.latitude, lon: coordinate.longitude)) else { return }
        getWeatherInternal(city: city, for: url)
    }
    
    private func getWeatherInternal(city: String, for url: URL) {
        NetworkManager<WeatherRo>.fetch(for: url) { [weak self] in
            guard let self = self,
                  case .success(let weather) = $0 else { return }
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
    }
}
