//
//  ContentView.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = CityViewModel()
    
    init(viewModel: CityViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MenuHeader(viewModel: viewModel)
                    .padding()
                ScrollView(showsIndicators: false) {
                    CityView(viewModel: viewModel)
                }.padding(.top, 10)
            }.padding(.top, 40)
        }.background(
            LinearGradient(gradient: Gradient(colors: [.red, .purple]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CityViewModel())
    }
}
