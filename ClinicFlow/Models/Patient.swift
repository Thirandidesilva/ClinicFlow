//
//  Patient.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-02.
//

import Foundation

struct Patient: Identifiable, Hashable {
    let id: String
    let name: String
}

extension Patient {
    static let samplePatients = [
        Patient(id: "1", name: "Kaveen De Silva"),
        Patient(id: "2", name: "Sunethri Ranaweera"),
        Patient(id: "3", name: "Suni De Silva")
    ]
}
