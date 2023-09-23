//
//  ContentView.swift
//  WeSplit
//
//  Created by stranger on 2023-09-22.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	
	let tipPercentages = [10, 15, 20, 25, 0]
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
				}
				
				Section {
					Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
				}
			}
			.navigationTitle("WeSplit")
		}
	}
}

#Preview {
    ContentView()
}
