//
//  LabViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import Foundation
import Combine
import SwiftUI

class LabViewModel: ObservableObject {
    @Published var labToken: String = "L-08"
    @Published var emergencyLabToken: String = "E-08"
    @Published var currentStepIndex: Int = 0
    @Published var steps: [LabSteps] = []
    @Published var currentStatus: String = "Preparing"
    @Published var estimatedReadyTime: String = "2.30 PM"
    @Published var isCompleted: Bool = false
    @Published var showCompletedAlert: Bool = false
    @Published var showCancelPopup: Bool = false
    
//    @Published var preparationInstructions: [PreparationInstruction] = [
//        PreparationInstruction(
//            icon: "scissors",
//            text: "Please fast for 8 hours prior to your test. No food or drinks (except water) after midnight."
//        ),
//        PreparationInstruction(
//            icon: "doc.text",
//            text: "Bring any relevant medical reports or referral letters"
//        )
//    ]
    
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
            LabSteps(id: "1", number: 1, title: "Token Received", status: .completed),
            LabSteps(id: "2", number: 2, title: "Got the Prescription", status: .inProgress),
            LabSteps(id: "3", number: 3, title: "Collect Sample", status: .pending),
            LabSteps(id: "4", number: 4, title: "Preparing Report", status: .notStarted),
            LabSteps(id: "5", number: 5, title: "Get your Report", status: .notStarted)
        ]
        currentStepIndex = 1 // Start at "Got the Prescription"
        updateStatus()
    }
    
    // MARK: - Start Step Progression
    func startStepProgression() {
        timer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
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
            currentStatus = "Collecting"
        case 3:
            currentStatus = "Almost Ready"
        case 4:
            currentStatus = "Preparing"
        default:
            currentStatus = "Completed"
        }
    }
    
    // MARK: - Complete Lab
    func completeLab() {
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
