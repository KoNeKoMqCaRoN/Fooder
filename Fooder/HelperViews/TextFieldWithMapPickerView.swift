//
//  TextFieldWithMapPickerView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import SwiftUI

struct TextFieldWithMapPickerView: View {
    
    @Binding var adress: String
    @Binding var lat: Double
    @Binding var lng: Double
    
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $adress)
            .keyboardType(.default)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .foregroundStyle(.gray.opacity(0.1))
            )
            .overlay(alignment: .trailing) {
                NavigationLink {
                    Text("Map Picker")
                } label: {
                    Image(systemName: "map")
                        .font(.title3.bold())
                        .foregroundStyle(.green)
                        .padding()
                }
            }
    }
}


#Preview {
    @Previewable
    @State var adress: String = ""
    @Previewable
    @State var lat: Double = 0.31
    @Previewable
    @State var lng: Double = 0.13

    TextFieldWithMapPickerView(
        adress: $adress,
        lat: $lat,
        lng: $lng,
        placeholder: "例：東京都千代田区"
    )
}
