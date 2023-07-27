//
//  ConfigView.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/27/23.
//

import SwiftUI

struct ConfigView: View {
    @ObservedObject var viewModel: EstimatorMainViewModel
    
    var body: some View {
        VStack {
            Toggle(isOn: $viewModel.selfEmployed) {
                Text("Self Employed")
            }
            .padding(.horizontal)
            
            Toggle(isOn: $viewModel.joint) {
                Text("Filing Jointly")
            }
            .padding(.horizontal)
            HStack {
                Text("State of residence:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Picker("State", selection: $viewModel.state) {
                    ForEach(StateTaxTable.taxTable.keys.sorted(), id: \.self) { key in
                        Text(key)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(viewModel: EstimatorMainViewModel())
    }
}
