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
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = [10, 15, 20, 25, 0]
	
	var totalCheck: Double {
		let tipSelection = Double(tipPercentage)
		let tipValue = checkAmount / 100 * tipSelection
		
		return checkAmount + tipValue
	}
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		return totalCheck / peopleCount
	}
	
	var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Subtotal amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
				} header: {
					Text("Subtotal")
				}
				
				Section {
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("How much tip do you want to leave?")
				}
				
				Section {
					Text(totalCheck, format:
							.currency(code: Locale.current.currency?.identifier ?? "USD")
					)
				} header: {
					Text("Check total")
				}
				
				Section {
					Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
				} header: {
					Text("Each should give")
				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					
					Button("Done") {
						amountIsFocused = false
					}
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
