//
//  ContentView.swift
//  WeSplit
//
//  Created by stranger on 2023-09-22.
//

import SwiftUI

struct ContentView: View {
	private var currencyCode: String {
		return Locale.current.currency?.identifier ?? "USD"
	}

	private var currency: FloatingPointFormatStyle<Double>.Currency {
		.currency(code: currencyCode)
	}
	
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = Array(0..<101)
	
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
//					.pickerStyle(.segmented)
				} header: {
					Text("How much tip do you want to leave?")
				}
				
				Section {
					Text(totalCheck, format: currency)
						.foregroundStyle(tipPercentage == 0 ? .red : .primary)
				} header: {
					Text("Check total")
				}
				
				Section {
					Text(totalPerPerson, format: currency)
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
