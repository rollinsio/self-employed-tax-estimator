//
//  File.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/26/23.
//

import Foundation

struct StateTaxTable {
    static let taxTable: [String:[TaxBracket]] =
    [
        "VA" : [
            TaxBracket(min: 0, max: 3000, rate: 0.02),
            TaxBracket(min: 3000, max: 5000, rate: 0.03),
            TaxBracket(min: 5000, max: 17000, rate: 0.05),
            TaxBracket(min: 17000, max: Double.infinity, rate: 0.0575)
        ]
    ]
}
