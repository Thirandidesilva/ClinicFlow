//
//  ConsultationViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import Foundation
import Combine
import SwiftUI

class ConsultationViewModel: ObservableObject {
    @Published var myToken: String = "A24"
    @Published var currentServingNumber: Int = 21  // "Now" number
    @Published var myQueueNumber: Int = 24
    @Published var queueItems: [QueueItem] = []
    @Published var estimatedWaitTime: String = "~45 min"
    @Published var peopleAhead: Int = 3
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var showReviewPage: Bool = false
    
    private var timer: Timer?
    private var hasShownTwoAheadAlert = false
    private var hasShownOneAheadAlert = false
    private var hasShownMyTurnAlert = false
    
    init() {
        updateQueueDisplay()
        startQueueSimulation()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    var isMyTurnCompleted: Bool {
        return currentServingNumber > myQueueNumber
    }
    
    // MARK: - Queue Simulation
    func startQueueSimulation() {
        // Simulate queue progression every 10 seconds (representing 15 min per patient)
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.advanceQueue()
        }
    }
    
    func advanceQueue() {
        // Move to next number
        currentServingNumber += 1
        updateQueueDisplay()
        checkForAlerts()
    }
    
    // MARK: - Update Queue Display
    func updateQueueDisplay() {
        queueItems = generateQueueItems()
        calculateWaitTime()
        calculatePeopleAhead()
    }
    
    // MARK: - Generate Queue Items
    func generateQueueItems() -> [QueueItem] {
        var items: [QueueItem] = []
        
        // Show 5 numbers: 2 done, 1 now, 1 next, 1 you/upcoming
        for i in 0..<5 {
            let number = currentServingNumber - 2 + i
            var status: QueueItem.QueueStatus
            
            if i == 0 || i == 1 {
                // Done numbers
                status = .done
            } else if i == 2 {
                // Current "Now" number being served
                status = .current
            } else if i == 3 {
                // Next number or "You" if it's user's number
                status = number == myQueueNumber ? .user : .next
            } else {
                // Upcoming numbers
                status = number == myQueueNumber ? .user : .upcoming
            }
            
            items.append(QueueItem(id: UUID().uuidString, number: number, status: status))
        }
        
        return items
    }
    
    
    
    // MARK: - Calculate Wait Time
    func calculateWaitTime() {
        let numbersAhead = max(0, myQueueNumber - currentServingNumber)
        let minutes = numbersAhead * 15 // 15 min per person
        
        if minutes == 0 {
            estimatedWaitTime = "Now"
        } else if minutes < 60 {
            estimatedWaitTime = "~\(minutes) min"
        } else {
            let hours = minutes / 60
            let remainingMins = minutes % 60
            estimatedWaitTime = remainingMins > 0 ? "~\(hours)h \(remainingMins)m" : "~\(hours)h"
        }
    }
    
    // MARK: - Calculate People Ahead
    func calculatePeopleAhead() {
        peopleAhead = max(0, myQueueNumber - currentServingNumber)
    }
    
    // MARK: - Check for Alerts
    func checkForAlerts() {
        let currentlyServing = currentServingNumber
        
        // Alert when serving number 22 (2 patients away from 24)
        if currentlyServing == myQueueNumber - 2 && !hasShownTwoAheadAlert {
            alertMessage = "Now serving \(currentlyServing). Only two patients away!"
            showAlert = true
            hasShownTwoAheadAlert = true
        }
        // Alert when serving number 23 (1 patient away from 24)
        else if currentlyServing == myQueueNumber - 1 && !hasShownOneAheadAlert {
            alertMessage = "Now serving \(currentlyServing). Only one patient ahead!"
            showAlert = true
            hasShownOneAheadAlert = true
        }
        // Alert when it's your turn (serving 24)
        else if currentlyServing == myQueueNumber && !hasShownMyTurnAlert {
            alertMessage = "It's your turn! Please proceed to the consultation room."
            showAlert = true
            hasShownMyTurnAlert = true
        }
    }
    
    // MARK: - Get Estimated Consultation Time
    func getEstimatedConsultationTime() -> String {
        let numbersAhead = max(0, myQueueNumber - currentServingNumber)
        let minutes = numbersAhead * 15
        
        let now = Date()
        let estimatedTime = Calendar.current.date(byAdding: .minute, value: minutes, to: now)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        return estimatedTime != nil ? formatter.string(from: estimatedTime!) : "N/A"
    }
    
    // MARK: - Complete Session Action
    func completeSession() {
        timer?.invalidate()
        showReviewPage = true
    }
}
