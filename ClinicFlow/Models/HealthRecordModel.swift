//
//  HealthRecordModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-28
//

import SwiftUI

// MARK: - Vital Model
struct Vital: Hashable {
    var heartRate: String = "72"
    var bloodPressure: String = "120/80"
    var weight: String = "68"
    var bloodSugar: String = "95"
}

// MARK: - Medical Info Model
struct MedicalInfo: Hashable {
    var bloodType: String = "A+"
    var allergies: String = "2 Active"
    var vaccinations: String = "Updated"
}

// MARK: - Medication Model
struct Medication: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var status: String = "Active"
}

// MARK: - Patient Record Model
struct PatientRecord: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var lastUpdated: String
    var initials: String
    var avatarColor: Color
    var vitals: Vital
    var medicalInfo: MedicalInfo
    var medications: [Medication]

    static func == (lhs: PatientRecord, rhs: PatientRecord) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Family / Other Patient Model
struct OtherPatient: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var age: String
    var initials: String
    var avatarColor: Color
    var record: PatientRecord

    static func == (lhs: OtherPatient, rhs: OtherPatient) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
