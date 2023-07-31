//
//  EstimatorMainView.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/26/23.
//

import SwiftUI

struct EstimatorMainView: View {
    enum Field: Hashable {
        case grossIncome, extraExpenses
    }
    
    @ObservedObject var viewModel: EstimatorMainViewModel
    
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
    @FocusState private var focusedField: Field?
    
    @State var showTaxBurdenInfoSheet: Bool = false
    @State var showConfigSheet: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Total Tax Burden")
                    .font(.title)
                Text("\(viewModel.totalTaxBurden, specifier: "%.0f")")
                    .foregroundColor(.red)
                    .font(.title)
                Button("Details") {
                    showTaxBurdenInfoSheet = true
                }
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .sheet(isPresented: $showTaxBurdenInfoSheet) {
                TaxBurdenInfoView(viewModel: viewModel)
            }
            
            VStack {
                Text("Take Home:")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("\(viewModel.totalTakeHome, specifier: "%.0f")")
                    .font(.title)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            VStack {
                Text("Rates")
                    .font(.title)
                Text("40 hrs/wk: \(viewModel.grossIncome/50/40, specifier: "%.0f")")
                Text("30 hrs/wk: \(viewModel.grossIncome/50/30, specifier: "%.0f")")
                Text("20 hrs/wk: \(viewModel.grossIncome/50/20, specifier: "%.0f")")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            VStack {
                Text("Gross Income")
                TextField("Gross Income", value: $viewModel.grossIncome, formatter: numberFormatter)
                    .focused($focusedField, equals: .grossIncome)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                
                Text("Additional Expenses")
                TextField("Additional Expenses", value: $viewModel.additionalExpenses, formatter: numberFormatter)
                    .focused($focusedField, equals: .extraExpenses)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                
                HStack {
                    Button("Reset") {
                        viewModel.reset()
                        viewModel.additionalExpenses = 0
                        viewModel.grossIncome = 0
                    }
                    
                    Button("Calculate") {
                        viewModel.calculateTotalTakeHome()
                        focusedField = nil
                    }
                }
                Button("Config") {
                    showConfigSheet = true
                }
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .sheet(isPresented: $showConfigSheet) {
                ConfigView(viewModel: viewModel)
            }
            
            Spacer()
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

struct EstimatorMainView_Previews: PreviewProvider {
    static var previews: some View {
        EstimatorMainView(viewModel: EstimatorMainViewModel())
    }
}
