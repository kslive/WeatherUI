//
//  HourlyWeather.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

struct HourlyWeather: View {
    @ObservedObject private var viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                if let hourly = viewModel.weather.hourly {
                    ForEach(hourly) { weather in
                        if let dt = weather.dt, let temp = weather.temp, let detailWeathers = weather.weather {
                            let icon = viewModel
                                .getWeatherIconFor(
                                    icon: !detailWeathers.isEmpty ?
                                    detailWeathers[0].icon ?? "sun.max.fill"  : "sun.max.fill"
                                )
                            let hour = viewModel.getTimeFor(timestamp: dt)
                            let temp = viewModel.getTempFor(temp: temp)
                            getHourlyView(hour: hour, image: icon, temp: temp)
                        }
                    } // ForEach
                }
            } // HStack
        } // ScrollView
    }
    
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        VStack(spacing: 20) {
            Text(hour)
            image
                .foregroundColor(.yellow)
            Text(temp)
        } // VStack
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.red, .purple]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
        )
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}

struct HourlyWeather_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeather(viewModel: CityViewModel())
    }
}
