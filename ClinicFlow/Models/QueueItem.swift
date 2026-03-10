//
//  QueueItem.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//



import Foundation

struct QueueItem: Identifiable, Equatable {
    let id: String
    let number: Int
    
    
    var status: QueueStatus
    
    enum QueueStatus: Equatable {
        case done // Completed consultations
        case current // Currently being served - Now
        case next // Next in line
        case user // User number
        case upcoming // Future numbers
    }
}
