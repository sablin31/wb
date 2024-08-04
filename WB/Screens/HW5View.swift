//
//  HW5View.swift
//  WB
//
//  Created by Aleksei Sablin on 24.07.2024.
//

import SwiftUI

struct HW5View: View {

    // MARK: Private properties

    @EnvironmentObject private var languageManager: LanguageManager
    @State private var currentDate = Date()
    private let valueInMeters: Double = 1250

    // MARK: Computed properties

    var body: some View {
        VStack {
            Button("switchLanguage".localized.capitalized) {
                languageManager.currentLanguage = languageManager.currentLanguage == "en" ? "ru" : "en"
            }
            .foregroundColor(.black)
            .padding()
            Text("currentDate".localized.capitalized).font(.title)
            makeDate().padding()
            Text("currentTime".localized.capitalized).font(.title)
            makeTime().padding()
            Text("measurements".localized.capitalized).font(.title)
            makeMeasurements().padding()
        }.onAppear(perform: startTime)
    }
}
// MARK: - Private methods

private extension HW5View {
    func makeDate() -> some View {
        VStack(alignment: .leading) {
            Text("short".localized.capitalized + ": \(Date().formattedDate(dateStyle: .short))")
            Text("medium".localized.capitalized + ": \(Date().formattedDate(dateStyle: .medium))")
            Text("long".localized.capitalized + ": \(Date().formattedDate(dateStyle: .long))")
        }
    }
    
    func makeTime() -> some View {
        VStack(alignment: .leading) {
            Text("short".localized.capitalized + ": \(currentDate.formattedDate(dateFormat: "HH:mm"))")
            Text("medium".localized.capitalized + ": \(currentDate.formattedDate(dateFormat: "HH:mm:ss"))")
            Text("long".localized.capitalized + ": \(currentDate.formattedDate(dateFormat: "HH:mm:ss.SSS"))")
        }
    }
    
    func makeMeasurements() -> some View {
        VStack(alignment: .leading) {
            Text("meters".localized.capitalized + ": \(valueInMeters) " + "m".localized)
            if Locale.current.region?.identifier == "RU" {
                Text("kilometers".localized.capitalized + ": \(convertDistance(valueInMeters, unit: .meters, to: .kilometers)) " + "km".localized)
            } else {
                Text("miles".localized.capitalized + ": \(convertDistance(valueInMeters, unit: .meters, to: .miles)) " + "miles".localized)
            }
        }
    }

    // MARK: Helpers

    func startTime() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentDate = Date()
        }
    }

    func convertDistance<T: BinaryFloatingPoint>(_ value: T, unit: UnitLength, to convertUnit: UnitLength) -> String {
        let measurement = Measurement(value: Double(value), unit: unit)
        let convertedMeasurement = measurement.converted(to: convertUnit)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        
        let result = numberFormatter.string(from: NSNumber(value: convertedMeasurement.value)) ?? ""
        return result
    }
}
// MARK: - Preview

#Preview {
    HW5View()
        .environmentObject(LanguageManager.shared)
}
