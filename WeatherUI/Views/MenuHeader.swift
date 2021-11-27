//
//  MenuHeader.swift
//  WeatherUI
//
//  Created by Eugene Kiselev on 27.11.2021.
//

import SwiftUI

struct MenuHeader: View {
    @ObservedObject private var viewModel: CityViewModel
    @State private var searchText = "Moscow"
    
    init(viewModel: CityViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        HStack {
            TextField("", text: $searchText)
                .padding(.leading, 20)
            
            Button {
                viewModel.city = searchText
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.purple)
                    
                    Image(systemName: "location.fill")
                } // ZStack
            } // Button
            .frame(width: 50, height: 50)
        } // HStack
        .foregroundColor(.white)
        .padding()
        .background(
            ZStack(alignment: .leading) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.2))
            } // ZStack
        )
    }
}

struct MenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeader(viewModel: CityViewModel())
    }
}
