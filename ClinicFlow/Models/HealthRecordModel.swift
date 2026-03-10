//
//  HealthRecordModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-28
//

import SwiftUI

// MARK: - Vital Model
struct Vital {
    var heartRate: String = "72"
    var bloodPressure: String = "120/80"
    var weight: String = "68"
    var bloodSugar: String = "95"
}

// MARK: - Medical Info Model
struct MedicalInfo {
    var bloodType: String = "A+"
    var allergies: String = "2 Active"
    var vaccinations: String = "Updated"
}

// MARK: - Medication Model
struct Medication: Identifiable {
    let id = UUID()
    var name: String
    var status: String = "Active"
}

// MARK: - Patient Record Model
struct PatientRecord: Identifiable {
    let id = UUID()
    var name: String
    var lastUpdated: String
    var initials: String
    var avatarColor: Color
    var vitals: Vital
    var medicalInfo: MedicalInfo
    var medications: [Medication]
}

// MARK: - Family / Other Patient Model
struct OtherPatient: Identifiable {
    let id = UUID()
    var name: String
    var age: String
    var initials: String
    var avatarColor: Color
    var record: PatientRecord
}
