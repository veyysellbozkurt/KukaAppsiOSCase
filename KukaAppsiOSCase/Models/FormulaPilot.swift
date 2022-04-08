//
//  FormulaModel.swift
//  KukaAppsiOSCase
//
//  Created by Veysel Bozkurt on 7.04.2022.
//

import Foundation

// MARK: - Formula Pilots
struct FormulaPilots: Codable {
    let items: [Pilot]?
}

// MARK: - Pilot
struct Pilot: Codable {
    let id: Int?
    let name: String?
    let point: Int?
    
}
