//
//  LabSteps.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import Foundation

struct LabSteps: Identifiable, Equatable {
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

extension LabSteps {
    static let labSteps = [
        LabSteps(id: "1", number: 1, title: "Token Received", status: .completed),
        LabSteps(id: "2", number: 2, title: "Got the Prescription", status: .inProgress),
        LabSteps(id: "3", number: 3, title: "Collect Sample", status: .pending),
        LabSteps(id: "4", number: 4, title: "Preparing Report", status: .notStarted),
        LabSteps(id: "5", number: 5, title: "Get your Report", status: .notStarted)
    ]
}
 
