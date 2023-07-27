//
//  FederalTaxTable.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/26/23.
//

import Foundation

struct FederalTaxTable {
    static let taxTable: [TaxBracket] = [
        TaxBracket(min: 0.0, max: 11000, rate: 0.0),
        TaxBracket(min: 11000, max: 44725, rate: 0.12),
        TaxBracket(min: 44725, max: 95735, rate: 0.22),
        TaxBracket(min: 95735, max: 182100, rate: 0.24),
        TaxBracket(min: 182100, max: 231250, rate: 0.32),
        TaxBracket(min: 231250, max: Double.infinity, rate: 0.35)
    ]
    
    static let jointTaxTable: [TaxBracket] = [
        TaxBracket(min: 0.0, max: 22000, rate: 0.0),
        TaxBracket(min: 22000, max: 89450, rate: 0.12),
        TaxBracket(min: 89450, max: 190750, rate: 0.22),
        TaxBracket(min: 190750, max: 364200, rate: 0.24),
        TaxBracket(min: 364200, max: 462500, rate: 0.32),
        TaxBracket(min: 462500, max: Double.infinity, rate: 0.35)
    ]
}
