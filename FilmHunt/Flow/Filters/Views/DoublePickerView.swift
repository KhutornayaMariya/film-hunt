//
//  YearsPickerView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 04.02.24.
//

import SwiftUI

struct DoublePickerView: View {
    @Binding var selectedFirstComponent: Int
    @Binding var selectedSecondComponent: Int
    
    @State var firstComponentOptions: [Int]
    @State var secondComponentOptions: [Int]
    
    var body: some View {
        HStack {
            Picker("First Component", selection: $selectedFirstComponent) {
                ForEach(firstComponentOptions, id: \.self) { option in
                    Text(String(option))
                }
            }
            .pickerStyle(.wheel)
            
            Picker("Second Component", selection: $selectedSecondComponent) {
                ForEach(secondComponentOptions, id: \.self) { option in
                    Text(String(option))
                }
            }
            .pickerStyle(.wheel)
        }
        .padding()
    }
}

struct DoublePickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        let years = [1888, 1889, 1890, 1891, 2022, 2023, 2024]
        
        DoublePickerView(selectedFirstComponent: .constant(2), selectedSecondComponent: .constant(1), firstComponentOptions: years, secondComponentOptions: years)
    }
}
