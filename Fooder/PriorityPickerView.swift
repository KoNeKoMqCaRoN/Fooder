//
//  PriorityPickerView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import SwiftUI


// Database に保存するときは、.rawValue で
enum Priority: String, CaseIterable {
    case low
    case normal
    case high
    case urgent
    
    var japaneseString: String {
        switch self {
        case .low:
            return "低"
        case .normal:
            return "中"
        case .high:
            return "高"
        case .urgent:
            return "緊急"
        }
    }
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .normal:
            return .yellow
        case .high:
            return .orange
        case .urgent:
            return .red
        }
    }
}

struct PriorityPickerView: View {
    @Binding var selectedPriority: Priority
    @Binding var showUrgentPriority: Bool
    
    private var visiblePriorities: [Priority] {
        return showUrgentPriority ? Priority.allCases :
        Priority.allCases.filter { $0 != .urgent }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 優先度ボタンのリスト
            HStack(spacing: 8) {
                ForEach(visiblePriorities, id: \.self) { priority in
                    priotyItemView(priority)
                }
            }
            .foregroundStyle(.black)

            // 災害地域にいる場合の注意文
            if showUrgentPriority {
                urgentNotesView
            }
        }
    }

    
    @ViewBuilder
    private func priotyItemView(_ priority: Priority) -> some View {
        let isSelected = selectedPriority == priority
        Button {
            selectedPriority = priority
        } label: {
            Text(priority.japaneseString)
                .font(.title2)
                .fontWeight(isSelected ? .heavy : .regular)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(isSelected ? priority.color : .clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 6))
                        .foregroundStyle(.gray.opacity(0.3))
                )
                .cornerRadius(10)
                .foregroundStyle(isSelected ? .white : .black)
                .animation(.smooth, value: isSelected)
        }

    }
    
    private var urgentNotesView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("※災害地域内のため「緊急」を選択できます。")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.red)
            
            Text("ただし、本当に緊急の場合のみ選択してください。")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("他にもっと困っている人がいるかもしれません。")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("ご協力をお願いいたします。")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.top, 4)
    }
}

#Preview {
    @Previewable
    @State var selectedPriority: Priority = .low
    @Previewable
    @State var showUrgentPriority: Bool = true
    PriorityPickerView(selectedPriority: $selectedPriority, showUrgentPriority: $showUrgentPriority)
}
