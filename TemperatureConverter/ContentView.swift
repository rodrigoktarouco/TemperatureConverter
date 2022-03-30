//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Rodrigo Tarouco on 30/03/22.
//

import SwiftUI

struct ContentView: View {
    let temperatureUnits: [String] = ["Celsius", "Fahreheit", "Kelvin"]
    @State private var inputNumber: Double = 0.0
    @State private var inputUnit: String = ""
    @State private var outputUnit: String = ""
    
    var baseTemp: Double {
        var base = 0.0
        switch inputUnit {
        case "Celsius":
            base = inputNumber
        case "Fahreheit":
            base = inputNumber * (9 / 5) + 32
        case "Kelvin":
            base = inputNumber + 273.15
        default: return base
        }
        return base
    }
    
    var finalTemp: Double {
        let base = baseTemp
        switch outputUnit {
        case "Celsius":
            if inputUnit == "Celsius" {
                return base
            } else if inputUnit == "Fahreheit" {
                return ((base - 32) * (5 / 9))
            } else {
                return base - 273.15
            }
        case "Fahreheit":
            if inputUnit == "Celsius" {
                return (base * (9 / 5)) + 32
            } else if inputUnit == "Fahreheit" {
                return base
            } else {
                return ((base - 32) * (5 / 9)) + 273.15
            }
        case "Kelvin":
            if inputUnit == "Celsius" {
               return base + 273.15
            } else if inputUnit == "Fahreheit" {
                return ((base - 273.15) * (9 / 5)) + 32
            } else {
                return base
            }
        default: return base
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $inputNumber, format: .number)
                } header: {
                    Text("Value To Convert")
                }
                
                Section {
                    Picker("Temperature Unit", selection: $inputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }.pickerStyle(.segmented)
                    }
                    Text(baseTemp, format: .number)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("Temperature Unit", selection: $outputUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }.pickerStyle(.segmented)
                    }
                    Text(finalTemp, format: .number)
                    
                } header: {
                    Text("To")
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
