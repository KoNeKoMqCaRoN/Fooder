//
//  CustomDatePickerView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import SwiftUI

struct CustomDatePickerView<Content: View>: View {
    @State private var showingPicker = false
    
    var title: String
    @Binding var selectedDate: Date
    
    // デフォルト：　明日
    var dateRange: PartialRangeFrom<Date>
    
    var label: () -> Content
    
    init(
        title: String = "",
        selectedDate: Binding<Date>,
        dateRange: PartialRangeFrom<Date> = {
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .day, value: 1, to: Date())!
            return startDate...
        }(),
        @ViewBuilder label: @escaping () -> Content
    ) {
        self.title = title
        self._selectedDate = selectedDate
        self.dateRange = dateRange
        self.label = label
    }
    
    var body: some View {
        
        label()
            .onTapGesture {
                showingPicker.toggle()
            }
            .sheet(isPresented: $showingPicker) {
                DatePickerSheet(selectedDate: $selectedDate, title: title, dateRange: dateRange)
                    .presentationDetents([.height(250)])
            }
    }
}

struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    let title: String
    @Environment(\.dismiss) private var dismiss
    var dateRange: PartialRangeFrom<Date>
        
    init(
        selectedDate: Binding<Date>,
        title: String,
        // デフォルト：　明日
        dateRange: PartialRangeFrom<Date> = {
            let calendar = Calendar.current
            let startDate = calendar.date(byAdding: .day, value: 1, to: Date())!
            return startDate...
        }()
    ) {
        self._selectedDate = selectedDate
        self.title = title
        self.dateRange = dateRange
    }

    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    title,
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                
                Spacer()
            }
            .padding()
            .navigationTitle(title.isEmpty ? "Select Date" : title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable
    @State var selectedDate: Date = Date()
    CustomDatePickerView(selectedDate: $selectedDate) {
        Text("Selected Date: \(selectedDate, style: .date)")
    }
}
