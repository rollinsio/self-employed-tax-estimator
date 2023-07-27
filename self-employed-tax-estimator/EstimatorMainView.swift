//
//  EstimatorMainView.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/26/23.
//

import SwiftUI

struct EstimatorMainView: View {
    @ObservedObject var viewModel: EstimatorMainViewModel
    
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
    var body: some View {
        VStack {
            Spacer()
            
            
            VStack {
                Text("Tax Burden")
                    .font(.title)
                    .padding(.bottom)
                
                HStack {
                    Text("Federal Tax Burden:")
                        .frame(width: 200, alignment: .leading)
                    Text("\(viewModel.federalTaxBurden, specifier: "%.0f")")
                        .foregroundColor(.red)
                }
                HStack {
                    Text("State Tax Burden:")
                        .frame(width: 200, alignment: .leading)
                    Text("\(viewModel.stateTaxBurden, specifier: "%.0f")")
                        .foregroundColor(.red)
                }
                HStack {
                    Text("FICA Tax Burden:")
                        .frame(width: 200, alignment: .leading)
                    Text("\(viewModel.ficaTaxBurden, specifier: "%.0f")")
                        .foregroundColor(.red)
                }
                HStack {
                    Text("Total Tax Burden:")
                        .frame(width: 200, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("\(viewModel.totalTaxBurden, specifier: "%.0f")")
                        .foregroundColor(.red)
                }
                .padding(.bottom)
            }
            .frame(minWidth: 300, idealWidth: 500, alignment: .center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            
            
            HStack {
                Text("Take Home:")
                    .frame(width: 200, alignment: .leading)
                Text("\(viewModel.totalTakeHome, specifier: "%.0f")")
                    .foregroundColor(.green)
                    .frame(alignment: .trailing)
                
                
            }
            .frame(minWidth: 300, idealWidth: 500, alignment: .center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            VStack {
                Text("Rates")
                Text("40 hrs/wk: \(viewModel.totalTakeHome/12/4/40, specifier: "%.0f")")
                Text("30 hrs/wk: \(viewModel.totalTakeHome/12/4/30, specifier: "%.0f")")
                Text("20 hrs/wk: \(viewModel.totalTakeHome/12/4/20, specifier: "%.0f")")
            }
            .frame(minWidth: 300, idealWidth: 500, alignment: .center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            VStack {
                Text("Gross Income")
                TextField("Gross Income", value: $viewModel.grossIncome, formatter: numberFormatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                
                Text("Additional Expenses")
                TextField("Additional Expenses", value: $viewModel.additionalExpenses, formatter: numberFormatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 200)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal)
                
                Picker("State", selection: $viewModel.state) {
                    ForEach(StateTaxTable.taxTable.keys.sorted(), id: \.self) { key in
                        Text(key)
                    }
                }
                HStack {
                    Button("Reset") {
                        viewModel.reset()
                        viewModel.additionalExpenses = 0
                        viewModel.grossIncome = 0
                    }
                    .frame(width: 100)
                    
                    Button("Calculate") {
                        viewModel.calculateTotalTakeHome()
                    }
                    .frame(width: 100)
                }
            }
            .frame(minWidth: 300, idealWidth: 500, alignment: .center)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct EstimatorMainView_Previews: PreviewProvider {
    static var previews: some View {
        EstimatorMainView(viewModel: EstimatorMainViewModel())
    }
}
