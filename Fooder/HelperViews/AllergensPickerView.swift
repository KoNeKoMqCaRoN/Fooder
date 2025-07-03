//
//  AllergensPickerView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import SwiftUI

struct AllergensPickerView: View {
    @Binding var selectedAllergens: Set<Allergen>
    var body: some View {
        NavigationLink {
            AllergensListView(selectedAllergens: $selectedAllergens)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                if selectedAllergens.isEmpty {
                    HStack {
                        Text("選択してください")
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.green)
                    }
                    
                } else {
                    // 選択されたアレルギー
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: 80))
                    ], spacing: 6) {
                        ForEach(Array(selectedAllergens), id: \.self) { allergen in
                            Text(allergen.japaneseName)
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .frame(minWidth: 80)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 6)
                                .background(.red)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .foregroundStyle(.gray.opacity(0.1))
                    .opacity(selectedAllergens.isEmpty ? 1 : 0)
            )
        }
    }
}

#Preview {
    @Previewable @State var selectedAllergens: Set<Allergen> = []
    AllergensPickerView(selectedAllergens: $selectedAllergens)
}
