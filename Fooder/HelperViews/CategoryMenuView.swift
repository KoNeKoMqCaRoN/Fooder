//
//  CategoryMenuView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import SwiftUI

struct CategoryMenuView: View {
    @Binding var selectedFoodCategory: FoodCategory
    var body: some View {
        Menu {
            ForEach(FoodCategory.allCases, id: \.self) { category in
                Button {
                    selectedFoodCategory = category
                } label: {
                    Text(category.japaneseName)
                        .bold()
                }
            }
        } label: {
            HStack {
                Text(selectedFoodCategory.japaneseName)
                Spacer()
                Image(systemName: "arrow.up.and.down")
                    .foregroundStyle(.green)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .foregroundStyle(.gray.opacity(0.2))
            )
            
        }
    }
}
