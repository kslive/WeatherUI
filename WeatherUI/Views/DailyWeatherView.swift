//
//  DailyWeatherView.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject private var viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ForEach(viewModel.weather.daily ?? []) { weather in
            LazyVStack {
                dailyCell(weather: weather)
            } // LazyVStack
        } // ForEach
    }
    
    private func dailyCell(weather: DailyWeather) -> some View {
        HStack {
            Text(viewModel.getDayFor(timestamp: weather.dt ?? 0).uppercased())
                .frame(width: 50)
            
            Spacer()
            
            Text(
                "\(viewModel.getTempFor(temp: weather.temp?.max ?? 0)) | \(viewModel.getTempFor(temp: weather.temp?.min ?? 0)) C"
            )
                .frame(width: 150)
            Spacer()
            viewModel
                .getWeatherIconFor(
                    icon: !(weather.weather ?? []).isEmpty ? weather.weather?[0].icon ?? "sun.max.fill" : "sun.max.fill"
                )
        } // HStack
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
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

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(viewModel: CityViewModel())
    }
}
