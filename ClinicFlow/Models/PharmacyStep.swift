//
//  PharmacyStep.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-28.
//

import Foundation

struct PharmacyStep: Identifiable, Equatable {
    let id: String
    let number: Int
    let title: String
    var status: StepStatus
    
    enum StepStatus: Equatable {
        case completed
        case inProgress
        case pending
        case notStarted
    }
}

// Sample pharmacy steps
extension PharmacyStep {
    static let pharmacySteps = [
        PharmacyStep(id: "1", number: 1, title: "Token Received", status: .completed),
        PharmacyStep(id: "2", number: 2, title: "Got the Prescription", status: .inProgress),
        PharmacyStep(id: "3", number: 3, title: "Preparing Drugs", status: .pending),
        PharmacyStep(id: "4", number: 4, title: "Your Medicines is Ready", status: .notStarted)
    ]
}
