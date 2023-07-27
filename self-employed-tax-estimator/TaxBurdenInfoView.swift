//
//  TaxBurdenInfoView.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/27/23.
//

import SwiftUI

struct TaxBurdenInfoView: View {
    @ObservedObject var viewModel: EstimatorMainViewModel
    
    var body: some View {
        VStack {
            Text("Total Tax Burdent Details")
                .font(.title)
                .padding()
            
            HStack {
                Text("Federal Tax Burden:")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                Text("\(viewModel.federalTaxBurden, specifier: "%.0f")")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
            
            HStack {
                Text("State Tax Burden:")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                Text("\(viewModel.stateTaxBurden, specifier: "%.0f")")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
            
            HStack {
                Text("FICA:")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
                Text("\(viewModel.ficaTaxBurden, specifier: "%.0f")")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TaxBurdenInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TaxBurdenInfoView(viewModel: EstimatorMainViewModel())
    }
}
