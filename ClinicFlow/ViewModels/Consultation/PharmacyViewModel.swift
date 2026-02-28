//
//  PharmacyViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-28.
//

import Foundation
import Combine
import SwiftUI

class PharmacyViewModel: ObservableObject {
    @Published var pharmacyToken: String = "P-12"
    @Published var currentStepIndex: Int = 0
    @Published var steps: [PharmacyStep] = []
    @Published var currentStatus: String = "Preparing"
    @Published var estimatedReadyTime: String = "1.30 PM"
    @Published var isCompleted: Bool = false
    @Published var showCompletedAlert: Bool = false
    @Published var showCancelPopup: Bool = false
    
    private var timer: Timer?
    
    init() {
        setupSteps()
        startStepProgression()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    // MARK: - Setup Steps
    func setupSteps() {
        steps = [
            PharmacyStep(id: "1", number: 1, title: "Token\nReceived", status: .completed),
            PharmacyStep(id: "2", number: 2, title: "Got the\nPrescription", status: .inProgress),
            PharmacyStep(id: "3", number: 3, title: "Preparing\nDrugs", status: .pending),
            PharmacyStep(id: "4", number: 4, title: "not your\nMedicines", status: .notStarted)
        ]
        currentStepIndex = 1 // Start at "Got the Prescription"
        updateStatus()
    }
    
    // MARK: - Start Step Progression
    func startStepProgression() {
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.moveToNextStep()
        }
    }
    
    // MARK: - Move to Next Step
    func moveToNextStep() {
        guard currentStepIndex < steps.count - 1 else {
            // All steps completed
            completeAllSteps()
            return
        }
        
        // Mark current step as completed
        steps[currentStepIndex].status = .completed
        
        // Move to next step
        currentStepIndex += 1
        
        if currentStepIndex < steps.count {
            steps[currentStepIndex].status = .inProgress
            updateStatus()
        }
    }
    
    // MARK: - Complete All Steps
    func completeAllSteps() {
        timer?.invalidate()
        
        // Mark last step as completed
        if currentStepIndex < steps.count {
            steps[currentStepIndex].status = .completed
        }
        
        isCompleted = true
        currentStatus = "Completed"
        showCompletedAlert = true
    }
    
    // MARK: - Update Status
    func updateStatus() {
        switch currentStepIndex {
        case 0:
            currentStatus = "Token Received"
        case 1:
            currentStatus = "Processing"
        case 2:
            currentStatus = "Preparing"
        case 3:
            currentStatus = "Almost Ready"
        default:
            currentStatus = "Completed"
        }
    }
    
    // MARK: - Complete Pharmacy
    func completePharmacy() {
        timer?.invalidate()
        // Navigate to home
    }
    
    // MARK: - Show Cancel Popup
    func requestCancelToken() {
        showCancelPopup = true
    }
    
    // MARK: - Cancel Token
    func cancelToken() {
        timer?.invalidate()
        showCancelPopup = false
        // Handle cancellation
    }
}
