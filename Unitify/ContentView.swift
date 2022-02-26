//
//  ContentView.swift
//  Unitify
//
//  Created by Tommy Wong on 26/02/2022.
//

import SwiftUI

enum temperatureUnits: String, CaseIterable {
    case Celsius, Fahrenheit, Kelvin
}

struct ContentView: View {
    @State private var sourceTempUnit = temperatureUnits.Celsius
    @State private var sourceTempValue = 0.00
    @State private var outputTempUnit = temperatureUnits.Fahrenheit
    @FocusState private var focusInput: Bool
    
    private var outputTempValue: Double {
        switch (sourceTempUnit) {
        case temperatureUnits.Celsius:
            let value = Measurement(value: sourceTempValue, unit: UnitTemperature.celsius)
            switch (outputTempUnit) {
            case temperatureUnits.Fahrenheit:
                return value.converted(to: UnitTemperature.fahrenheit).value
            case temperatureUnits.Kelvin:
                return value.converted(to: UnitTemperature.kelvin).value
            default:
                return sourceTempValue
            }
            
        case temperatureUnits.Fahrenheit:
            let value = Measurement(value: sourceTempValue, unit: UnitTemperature.fahrenheit)
            switch (outputTempUnit) {
            case temperatureUnits.Celsius:
                return value.converted(to: UnitTemperature.celsius).value
            case (temperatureUnits.Kelvin):
                return value.converted(to: UnitTemperature.kelvin).value
            default:
                return sourceTempValue
            }
            
        case temperatureUnits.Kelvin:
            let value = Measurement(value: sourceTempValue, unit: UnitTemperature.kelvin)
            switch (outputTempUnit) {
            case temperatureUnits.Celsius:
                return value.converted(to: UnitTemperature.celsius).value
            case temperatureUnits.Fahrenheit:
                return value.converted(to: UnitTemperature.fahrenheit).value
            default:
                return sourceTempValue
            }
        }
    }
    
    private var formattedOutputValue: String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        
        switch (outputTempUnit) {
        case temperatureUnits.Celsius:
            let value = Measurement(value: outputTempValue, unit: UnitTemperature.celsius)
            return formatter.string(from: value)
        case temperatureUnits.Fahrenheit:
            let value = Measurement(value: outputTempValue, unit: UnitTemperature.fahrenheit)
            return formatter.string(from: value)
        case temperatureUnits.Kelvin:
            let value = Measurement(value: outputTempValue, unit: UnitTemperature.kelvin)
            return formatter.string(from: value)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit", selection: $sourceTempUnit) {
                        ForEach(temperatureUnits.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                    }
                    TextField("Value", value: $sourceTempValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusInput)
                } header: {
                    Text("Source Temperature")
                }
                
                Section {
                    Picker("Unit", selection: $outputTempUnit) {
                        ForEach(temperatureUnits.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                        }
                }
                    Text(formattedOutputValue)
                } header: {
                    Text("Output Temperature")
                }
            }
            .navigationTitle("Unitify")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        focusInput = false
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
