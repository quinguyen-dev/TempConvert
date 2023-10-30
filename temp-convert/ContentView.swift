//
//  ContentView.swift
//  temp-convert
//
//  Created by Qui Nguyen on 10/30/23.
//

import SwiftUI


struct ContentView: View {
    @State private var queryTemp = 32.0
    @State private var initialUnit = "Fahrenheit"
    @State private var targetUnit = "Celsius"
    
    private let temp = ["Fahrenheit", "Celsius", "Kelvin"]
    
    private var convertedTemp: Double {
        var celsiusTemp = 0.0;
        
        // Convert the query temp into celsius (baseline) */
        if (initialUnit == "Celsius") {
            celsiusTemp = queryTemp
        } else if (initialUnit == "Fahrenheit") {
            celsiusTemp = (queryTemp - 32) * 5 / 9
        } else {
            celsiusTemp = queryTemp - 273.15
        }
        
        // Convert to targeted temp unit
        if (targetUnit == "Celsius") {
            return celsiusTemp
        } else if (targetUnit == "Fahrenheit") {
            return celsiusTemp * 9 / 5 + 32
        } else {
            return celsiusTemp + 273.15
        }
    }
    
    private var postfix: String {
        if (targetUnit == "Fahrenheit") {
            return "ºF"
        } else if (targetUnit == "Celsius") {
            return "ºC"
        } else {
            return " K"
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section ("Initial information") {
                    LabeledContent {
                        TextField("Enter temperature", value: $queryTemp, format: .number)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("Temperature")
                    }
                
                    Picker("Convert from", selection: $initialUnit) {
                        ForEach(temp, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("Convert to", selection: $targetUnit) {
                        ForEach(temp, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section ("Converted temperature") {
                    Text("\(convertedTemp, specifier: "%.2f")\(postfix)")
                }
            }
            .navigationTitle("TempConvert")
        }
    }
}

#Preview {
    ContentView()
}
