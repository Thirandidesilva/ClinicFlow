//
//  BookAppointmentViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-02.
//

import Foundation
import Combine

class BookAppointmentViewModel: ObservableObject {
    @Published var selectedPatient: Patient?
    @Published var showPatientDropdown: Bool = false
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: String = "Morning"
    @Published var showValidationError: Bool = false
    @Published var validationMessage: String = ""
    @Published var navigateToAddPatient: Bool = false
    
    let patients: [Patient] = Patient.samplePatients
    let doctor: Doctor
    
    init(doctor: Doctor) {
        self.doctor = doctor
    }
    
    // MARK: - Patient Selection
    func selectPatient(_ patient: Patient?) {
        selectedPatient = patient
        showPatientDropdown = false
    }
    
    func addNewPatient() {
        navigateToAddPatient = true
    }
    
    // MARK: - Validation
    func validateBooking() -> Bool {
        if selectedPatient == nil {
            validationMessage = "Please select a patient"
            showValidationError = true
            return false
        }
        
        return true
    }
    
    // MARK: - Book Appointment
    func bookAppointment() {
        guard validateBooking() else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        print("Booking Appointment:")
        print("Doctor: \(doctor.name)")
        print("Patient: \(selectedPatient?.name ?? "")")
        print("Date: \(dateFormatter.string(from: selectedDate))")
        print("Time: \(selectedTime)")
        
        // TODO: Save to database or API
    }
}
