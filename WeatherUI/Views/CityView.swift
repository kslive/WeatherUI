//  CityView.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

struct CityView: View {
    @ObservedObject private var viewModel: CityViewModel
    
    init(viewModel: CityViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            CityName(model: .init(city: viewModel.city, date: viewModel.date))
                .shadow(radius: 0)
            TodayWeather(viewModel: viewModel)
                .padding()
            HourlyWeather(viewModel: viewModel)
            DailyWeatherView(viewModel: viewModel)
        } // VStack
        .padding(.bottom, 30)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(viewModel: CityViewModel())
    }
}
