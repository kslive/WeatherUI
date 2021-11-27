//
//  TodayWeather.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

struct TodayWeather: View {
    @ObservedObject var viewModel: CityViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {
                LottieView(name: viewModel.getLottieAnimationFor(icon: viewModel.weatherIcon))
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text("\(viewModel.temperature)C")
                        .font(.system(size: 42))
                    Text(viewModel.conditions)
                } // VStack
            } // HStack
            
            HStack {
                Spacer()
                widgetView(image: "wind", color: .green, title: "\(viewModel.windSpeed)mi/hr")
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "\(viewModel.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .red, title: "\(viewModel.rainChainces)")
                Spacer()
            } // HStack
        } // VStack
        .padding()
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [.red.opacity(0.5), .purple]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                )
                .opacity(0.3)
        )
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    
    private func widgetView(image: String, color: Color, title: String) -> some View {
        VStack {
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.purple)
                        .frame(width: 75, height: 75)
                        .shadow(radius: 20, x: 0, y: 20)
                )
            
            Text(title.isEmpty ? "-" : title)
                .fontWeight(.bold)
                .foregroundColor(Color.white.opacity(0.8))
        } // VStack
    }
}

struct TodayWeather_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeather(viewModel: CityViewModel())
    }
}
