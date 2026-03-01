//
//  AddPatientViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import Foundation
import Combine

class AddPatientViewModel: ObservableObject {
    // Personal Information
    @Published var fullName: String = "Kaveen de Silva"
    @Published var age: String = "24 yrs"
    @Published var gender: String = "Male"
    
    // Contact Information
    @Published var contactNumber: String = ""
    @Published var address: String = ""
    
    // Vitals
    @Published var weight: String = "Weight"
    @Published var bloodType: String = "Blood Group"
    @Published var bloodPressure: String = "Blood Pressure"
    @Published var bloodSugar: String = "Blood Sugar"
    
    // Medical Records
    @Published var medicalRecords: String = ""
    
    // Validation
    @Published var showValidationError: Bool = false
    @Published var validationMessage: String = ""
    
    // Options
    let genderOptions = ["Male", "Female", "Other"]
    let weightOptions = ["Weight", "40-50 kg", "50-60 kg", "60-70 kg", "70-80 kg", "80-90 kg", "90+ kg"]
    let bloodTypeOptions = ["Blood Group", "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
    let bloodPressureOptions = ["Blood Pressure", "Normal (120/80)", "Elevated (130/80)", "High (140/90)", "Low (90/60)"]
    let bloodSugarOptions = ["Blood Sugar", "Normal (70-100 mg/dL)", "Pre-diabetic (100-125 mg/dL)", "Diabetic (126+ mg/dL)"]
    
    // MARK: - Validation
    func validateForm() -> Bool {
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty {
            validationMessage = "Please enter patient name"
            showValidationError = true
            return false
        }
        
        if age.trimmingCharacters(in: .whitespaces).isEmpty {
            validationMessage = "Please enter age"
            showValidationError = true
            return false
        }
        
        if contactNumber.trimmingCharacters(in: .whitespaces).isEmpty {
            validationMessage = "Please enter contact number"
            showValidationError = true
            return false
        }
        
        return true
    }
    
    // MARK: - Add Patient
    func addPatient() {
        guard validateForm() else { return }
        
        print("Adding patient:")
        print("Name: \(fullName)")
        print("Age: \(age)")
        print("Gender: \(gender)")
        print("Contact: \(contactNumber)")
        print("Address: \(address)")
        print("Weight: \(weight)")
        print("Blood Type: \(bloodType)")
        print("Blood Pressure: \(bloodPressure)")
        print("Blood Sugar: \(bloodSugar)")
        print("Medical Records: \(medicalRecords)")
        
        // TODO: Save to database or API
    }
    
    // MARK: - Reset
    func reset() {
        fullName = ""
        age = ""
        gender = "Male"
        contactNumber = ""
        address = ""
        weight = "Weight"
        bloodType = "Blood Group"
        bloodPressure = "Blood Pressure"
        bloodSugar = "Blood Sugar"
        medicalRecords = ""
    }
}
