//
//  CityName.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

extension CityName {
    struct ViewModel {
        let city: String
        let date: String
    }
}

struct CityName: View {
    private let model: ViewModel
    
    init(model: ViewModel) {
        self.model = model
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10) {
                Text(model.city)
                    .font(.title)
                    .bold()
                Text(model.date)
            } // VStack
            .foregroundColor(.white)
        } // HStack
    }
}

struct CityName_Previews: PreviewProvider {
    static var previews: some View {
        CityName(model: .init(city: "Moscow", date: "11.11.2011"))
    }
}
