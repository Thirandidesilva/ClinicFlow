//
//  HealthRecordViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva
//

import SwiftUI
import Combine

class HealthRecordViewModel: ObservableObject {

    // MARK: - Tab Selection
    @Published var selectedTab: RecordTab = .yourRecords

    // MARK: - My Record
    @Published var myRecord: PatientRecord = PatientRecord(
        name: "Kaveen De Silva",
        lastUpdated: "Feb 20, 2026",
        initials: "K",
        avatarColor: Color(hex: "1A1AE6"),
        vitals: Vital(heartRate: "72", bloodPressure: "120/80", weight: "68", bloodSugar: "95"),
        medicalInfo: MedicalInfo(bloodType: "A+", allergies: "2 Active", vaccinations: "Updated"),
        medications: [
            Medication(name: "Metformin", status: "Active"),
            Medication(name: "Atorvastatin", status: "Active")
        ]
    )

    // MARK: - Family Members
    @Published var familyMembers: [OtherPatient] = [
        OtherPatient(
            name: "Sunethra Ranaweera",
            age: "Age 54",
            initials: "S",
            avatarColor: Color(hex: "E74C3C"),
            record: PatientRecord(
                name: "Sunethra Ranaweera",
                lastUpdated: "Feb 20, 2026",
                initials: "S",
                avatarColor: Color(hex: "E74C3C"),
                vitals: Vital(heartRate: "78", bloodPressure: "130/85", weight: "70", bloodSugar: "110"),
                medicalInfo: MedicalInfo(bloodType: "O+", allergies: "1 Active", vaccinations: "Updated"),
                medications: [
                    Medication(name: "Amlodipine", status: "Active"),
                    Medication(name: "Atorvastatin", status: "Active")
                ]
            )
        ),
        OtherPatient(
            name: "Ruwan De Silva",
            age: "Age 55",
            initials: "R",
            avatarColor: Color(hex: "2ECC71"),
            record: PatientRecord(
                name: "Ruwan De Silva",
                lastUpdated: "Feb 20, 2026",
                initials: "R",
                avatarColor: Color(hex: "2ECC71"),
                vitals: Vital(heartRate: "80", bloodPressure: "125/82", weight: "80", bloodSugar: "105"),
                medicalInfo: MedicalInfo(bloodType: "B+", allergies: "1 Active", vaccinations: "Updated"),
                medications: [
                    Medication(name: "Metformin", status: "Active")
                ]
            )
        ),
        OtherPatient(
            name: "Hirushi De Silva",
            age: "Age 19",
            initials: "H",
            avatarColor: Color(hex: "9B59B6"),
            record: PatientRecord(
                name: "Hirushi De Silva",
                lastUpdated: "Feb 20, 2026",
                initials: "H",
                avatarColor: Color(hex: "9B59B6"),
                vitals: Vital(heartRate: "70", bloodPressure: "115/75", weight: "55", bloodSugar: "88"),
                medicalInfo: MedicalInfo(bloodType: "AB+", allergies: "0 Active", vaccinations: "Updated"),
                medications: []
            )
        )
    ]

    // MARK: - Other Patients
    @Published var otherPatients: [OtherPatient] = [
        OtherPatient(
            name: "Sunil De Silva",
            age: "Age 44",
            initials: "S",
            avatarColor: Color(hex: "E74C3C"),
            record: PatientRecord(
                name: "Sunil De Silva",
                lastUpdated: "Feb 20, 2026",
                initials: "S",
                avatarColor: Color(hex: "E74C3C"),
                vitals: Vital(heartRate: "76", bloodPressure: "118/78", weight: "75", bloodSugar: "100"),
                medicalInfo: MedicalInfo(bloodType: "A+", allergies: "1 Active", vaccinations: "Updated"),
                medications: [
                    Medication(name: "Lisinopril", status: "Active")
                ]
            )
        ),
        OtherPatient(
            name: "Nimal Perera",
            age: "Age 50",
            initials: "N",
            avatarColor: Color(hex: "F39C12"),
            record: PatientRecord(
                name: "Nimal Perera",
                lastUpdated: "Feb 20, 2026",
                initials: "N",
                avatarColor: Color(hex: "F39C12"),
                vitals: Vital(heartRate: "82", bloodPressure: "128/84", weight: "82", bloodSugar: "115"),
                medicalInfo: MedicalInfo(bloodType: "O-", allergies: "2 Active", vaccinations: "Updated"),
                medications: [
                    Medication(name: "Metformin", status: "Active"),
                    Medication(name: "Aspirin", status: "Active")
                ]
            )
        )
    ]

    // MARK: - Save edited record
    func saveMyRecord(_ updated: PatientRecord) {
        myRecord = updated
    }
}

// MARK: - Tab Enum
enum RecordTab {
    case yourRecords
    case otherRecords
}
