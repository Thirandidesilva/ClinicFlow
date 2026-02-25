//
//  AppointmentDashVeiwModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import Foundation
import Combine

class AppointmentViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []
    @Published var filteredDoctors: [Doctor] = []
    @Published var recentConsultations: [Doctor] = []
    @Published var searchText: String = ""
    @Published var selectedSpecialty: Specialty? = nil
    @Published var isSearching: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadDoctors()
        setupSearchListener()
    }
    
    // MARK: - Load Data
    func loadDoctors() {
        doctors = Doctor.sampleDoctors
        recentConsultations = Array(Doctor.sampleDoctors.prefix(3))
        filteredDoctors = doctors
    }
    
    // MARK: - Search Functionality
    private func setupSearchListener() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.filterDoctors(searchText: searchText)
            }
            .store(in: &cancellables)
        
        $selectedSpecialty
            .sink { [weak self] _ in
                self?.filterDoctors(searchText: self?.searchText ?? "")
            }
            .store(in: &cancellables)
    }
    
    func filterDoctors(searchText: String) {
        isSearching = !searchText.isEmpty || selectedSpecialty != nil
        
        if searchText.isEmpty && selectedSpecialty == nil {
            filteredDoctors = doctors
            return
        }
        
        filteredDoctors = doctors.filter { doctor in
            let matchesSearch = searchText.isEmpty ||
                               doctor.name.localizedCaseInsensitiveContains(searchText) ||
                               doctor.speciality.localizedCaseInsensitiveContains(searchText)
            
            let matchesSpecialty = selectedSpecialty == nil ||
                                  doctor.speciality.localizedCaseInsensitiveContains(selectedSpecialty?.name ?? "")
            
            return matchesSearch && matchesSpecialty
        }
    }
    
    // MARK: - Voice Search (Placeholder)
    func startVoiceSearch() {
        // TODO: Implement speech recognition
        print("Voice search started")
    }
    
    // MARK: - Specialty Selection
    func selectSpecialty(_ specialty: Specialty) {
        if selectedSpecialty?.id == specialty.id {
            selectedSpecialty = nil
        } else {
            selectedSpecialty = specialty
        }
    }
    
    // MARK: - Book Appointment
    func bookAppointment(for doctor: Doctor) {
        print("Booking appointment with \(doctor.name)")
        // TODO: Navigate to booking page
    }
}
