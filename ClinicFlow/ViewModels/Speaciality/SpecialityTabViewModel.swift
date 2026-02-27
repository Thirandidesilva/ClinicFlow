//
//  SpecialityTabViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-26.
//

import Foundation
import Combine

class SpecialtyTabViewModel: ObservableObject {
    @Published var allDoctors: [Doctor] = []
    @Published var filteredDoctors: [Doctor] = []
    @Published var selectedSpecialty: Specialty
    @Published var searchText: String = ""
    @Published var specialties: [Specialty] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Load all specialties first
        let loadedSpecialties = Specialty.allSpecialties
        self.specialties = loadedSpecialties
        
        // Set "General" as default
        self.selectedSpecialty = loadedSpecialties.first ?? Specialty(id: "1", name: "General", imageName: "stethoscope", backgroundColor: "C8E6F5")
        
        loadDoctors()
        setupObservers()
    }
    
    // MARK: - Load Data
    func loadDoctors() {
        allDoctors = Doctor.sampleDoctors
        filterDoctors()
    }
    
    // MARK: - Setup Observers
    private func setupObservers() {
        // Observe search text changes with debounce
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterDoctors()
            }
            .store(in: &cancellables)
        
        // Observe specialty changes IMMEDIATELY (no debounce)
        $selectedSpecialty
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterDoctors()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Filter Logic
    func filterDoctors() {
        var result = allDoctors
        
        // ALWAYS filter by specialty - match exact specialty name
        result = result.filter { doctor in
            doctor.speciality.localizedCaseInsensitiveContains(selectedSpecialty.name)
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            result = result.filter { doctor in
                doctor.name.localizedCaseInsensitiveContains(searchText) ||
                doctor.speciality.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        filteredDoctors = result
    }
    
    // MARK: - Specialty Selection
    func selectSpecialty(_ specialty: Specialty) {
        selectedSpecialty = specialty
        // Immediately filter on selection
        filterDoctors()
    }
    
    // MARK: - Voice Search
    func startVoiceSearch() {
        // TODO: Implement speech recognition
        print("Voice search started")
    }
    
    // MARK: - Get Doctor Count
    func getDoctorCount() -> String {
        let count = filteredDoctors.count
        return count == 1 ? "01 Found" : String(format: "%02d Found", count)
    }
    
    // MARK: - Book Appointment
    func bookAppointment(for doctor: Doctor) {
        print("Booking appointment with \(doctor.name)")
        // TODO: Navigate to booking page
    }
}
