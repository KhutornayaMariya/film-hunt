//
//  FiltersView.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 04.02.24.
//

import SwiftUI

struct Filters {
    var releaseYear: ReleaseYearRange
    
    struct ReleaseYearRange {
        var startYears: [Int]
        var endYears: [Int]

        var startYear: Int
        var endYear: Int
    }
}

struct FiltersView: View {
    @Binding var selectedStartYear: Int
    @Binding var selectedEndYear: Int

    @State private var isSheetPresented = false
    @State private var yearOfRelease: String = "Any"
    
    var firstComponentOptions = [1990, 1992, 1995, 2004]
    var secondComponentOptions = [1990, 1992, 1995, 2010]

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Button("YEAR_OF_RELEASE".localized) {
                            isSheetPresented.toggle()
                        }
                        .sheet(isPresented: $isSheetPresented) {
                            DoublePickerView(selectedFirstComponent: $selectedStartYear, selectedSecondComponent: $selectedEndYear, firstComponentOptions: firstComponentOptions, secondComponentOptions: secondComponentOptions)
                                .presentationDetents([.fraction(0.3)])
                        }
                        Spacer()
                        Text(yearsTextValue())
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("FILTERS".localized)
        }
    }
    
    private func yearsTextValue() -> String {

        if selectedStartYear == 0, selectedEndYear != 0 {
            return "to \(selectedEndYear)"
        } else if selectedStartYear != 0, selectedEndYear == 0 {
            return "since \(selectedStartYear)"
        } else if selectedStartYear == 0, selectedEndYear == 0 {
            return "Any"
        }
        
        return "\(selectedStartYear) - \(selectedEndYear)"
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(selectedStartYear: .constant(0), selectedEndYear: .constant(0))
    }
}
