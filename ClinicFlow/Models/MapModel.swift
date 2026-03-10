//
//  MapModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-03-01.
//


import SwiftUI

// MARK: - Floor Enum
enum FloorLevel: String, CaseIterable {
    case ground  = "GROUND"
    case floor01 = "FLOOR 01"
    case floor02 = "FLOOR 02"
    case basement = "BASEMENT"
}

// MARK: - Recent Visit Model
struct RecentVisit: Identifiable {
    let id: UUID = UUID()
    let imageName: String
    let name: String
    let floor: String
    let speciality: String
    let availableDays: String
}
