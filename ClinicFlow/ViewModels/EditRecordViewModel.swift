//
//  EditRecordViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-28
//

import SwiftUI
import Combine

class EditRecordViewModel: ObservableObject {
    @Published var fullName: String
    @Published var age: String
    @Published var gender: String
    @Published var heartRate: String
    @Published var bloodPressure: String
    @Published var weight: String
    @Published var bloodSugar: String
    @Published var bloodType: String
    @Published var allergies: String
    @Published var vaccinations: String
    @Published var medications: [Medication]

    private var healthRecordViewModel: HealthRecordViewModel

    init(healthRecordViewModel: HealthRecordViewModel) {
        self.healthRecordViewModel = healthRecordViewModel
        let r = healthRecordViewModel.myRecord
        self.fullName     = r.name
        self.age          = "25"
        self.gender       = "Male"
        self.heartRate    = r.vitals.heartRate
        self.bloodPressure = r.vitals.bloodPressure
        self.weight       = r.vitals.weight
        self.bloodSugar   = r.vitals.bloodSugar
        self.bloodType    = r.medicalInfo.bloodType
        self.allergies    = r.medicalInfo.allergies
        self.vaccinations = r.medicalInfo.vaccinations
        self.medications  = r.medications
    }

    func save() {
        let updated = PatientRecord(
            name: fullName,
            lastUpdated: "Feb 20, 2026",
            initials: String(fullName.prefix(1)),
            avatarColor: Color(hex: "1A1AE6"),
            vitals: Vital(heartRate: heartRate, bloodPressure: bloodPressure, weight: weight, bloodSugar: bloodSugar),
            medicalInfo: MedicalInfo(bloodType: bloodType, allergies: allergies, vaccinations: vaccinations),
            medications: medications
        )
        healthRecordViewModel.saveMyRecord(updated)
    }
}
