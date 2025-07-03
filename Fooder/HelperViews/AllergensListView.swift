//
//  allergensPickerView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import SwiftUI

struct AllergensListView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedAllergens: Set<Allergen>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                        
                        AllergenCard(
                            allergen: .none,
                            isSelected: selectedAllergens.contains(.none)
                        ) {
                            toggleSelection(for: .none)
                        }
                        
                    // 特定原材料（7品目
                    VStack(alignment: .leading, spacing: 12) {
                        Text("特定原材料（7品目）")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 160))
                        ], spacing: 8) {
                            ForEach(Allergen.majorAllergens, id: \.self) { allergen in
                                AllergenCard(
                                    allergen: allergen,
                                    isSelected: selectedAllergens.contains(allergen)
                                ) {
                                    toggleSelection(for: allergen)
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // 特定原材料に準ずるもの（21品目）
                    VStack(alignment: .leading, spacing: 12) {
                        Text("特定原材料に準ずるもの（21品目）")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 160))
                        ], spacing: 8) {
                            ForEach(Allergen.minorAllergens, id: \.self) { allergen in
                                AllergenCard(
                                    allergen: allergen,
                                    isSelected: selectedAllergens.contains(allergen)
                                ) {
                                    toggleSelection(for: allergen)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("アレルゲン選択")
            .navigationBarItems(trailing: clearButton)
        }
    }
    
    private var clearButton: some View {
        Button("クリア") {
            selectedAllergens.removeAll()
        }
        .tint(.red)
        .disabled(selectedAllergens.isEmpty)
    }
    
    private func toggleSelection(for allergen: Allergen) {
        if selectedAllergens.contains(allergen) {
            selectedAllergens.remove(allergen)
        } else {
            if allergen == .none {
                // 該当なし　を選択したら、他のアレルゲンを外す
                selectedAllergens.removeAll()
                selectedAllergens.insert(.none)
            } else {
                // 他のアレルゲンを選択したら、該当なしを外す
                selectedAllergens.remove(.none)
                selectedAllergens.insert(allergen)
            }
        }
    }
    
}

struct AllergenCard: View {
    let allergen: Allergen
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 6) {
                Text(allergen.japaneseName)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.red : Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.red : Color.clear, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    @Previewable
    @State var selectedAllergens: Set<Allergen> = []
    AllergensListView(selectedAllergens: $selectedAllergens)
}
