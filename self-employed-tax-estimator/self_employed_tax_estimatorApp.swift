//
//  self_employed_tax_estimatorApp.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/26/23.
//

import SwiftUI

@main
struct self_employed_tax_estimatorApp: App {
    var body: some Scene {
        WindowGroup {
            EstimatorMainView(viewModel: EstimatorMainViewModel())
        }
    }
}
