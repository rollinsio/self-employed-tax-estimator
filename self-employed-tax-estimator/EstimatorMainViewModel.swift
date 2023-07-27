//
//  EstimatorMainViewModel.swift
//  self-employed-tax-estimator
//
//  Created by Michael Rollins on 7/26/23.
//

import Foundation

class EstimatorMainViewModel: ObservableObject {
    @Published var grossIncome: Double = 0.0
    @Published var totalTaxBurden: Double = 0.0
    @Published var federalTaxBurden: Double = 0.0
    @Published var ficaTaxBurden: Double = 0.0
    @Published var stateTaxBurden: Double = 0.0
    @Published var state: String = "VA"
    @Published var additionalExpenses: Double = 0.0
    @Published var totalTakeHome: Double = 0.0
    
    
    
    let FICA = 0.153
    
    func calculateTotalTakeHome() {
        calculateTotalTaxBurden(joint: true)
        totalTakeHome = grossIncome - totalTaxBurden - additionalExpenses
    }
    
    
    
    func calculateTotalTaxBurden(joint: Bool) {
        reset()
        totalTaxBurden += calculateFederalTaxBurden(joint: joint)
        ficaTaxBurden = FICA * grossIncome
        totalTaxBurden += ficaTaxBurden
        totalTaxBurden += calculateStateTaxBurden(joint: joint, state: state)
    }
    
    func reset() {
        totalTaxBurden = 0.0
        federalTaxBurden = 0.0
        ficaTaxBurden = 0.0
        stateTaxBurden = 0.0
        totalTakeHome = 0.0
    }
    
    func calculateFederalTaxBurden(joint: Bool) -> Double {
        let bracket = joint ? FederalTaxTable.jointTaxTable : FederalTaxTable.taxTable
        
        let burden = calculateBracket(bracket: bracket)
        
        federalTaxBurden = burden
        return federalTaxBurden
    }
    
    func calculateStateTaxBurden(joint: Bool, state: String) -> Double {
        guard let bracket = StateTaxTable.taxTable[state] else {
            stateTaxBurden = 0.0
            return 0.0
        }
        
        let burden = calculateBracket(bracket: bracket)
        
        stateTaxBurden = burden
        return stateTaxBurden
    }
    
    func calculateBracket(bracket: [TaxBracket]) -> Double {
        var burden = 0.0
        
        for i in 0..<bracket.count {
            let min = bracket[i].min
            let max = bracket[i].max
            let rate = bracket[i].rate
            
            if grossIncome > min {
                if grossIncome > max {
                    burden += (max - min) * rate
                } else {
                    burden += (grossIncome - min) * rate
                }
            }
        }
        
        return burden
    }
}
