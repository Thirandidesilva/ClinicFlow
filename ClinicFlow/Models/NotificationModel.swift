//
//  NotificationModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-03-01.
//


import SwiftUI

// MARK: - Notification Type
enum NotificationType {
    case blue
    case red
}

// MARK: - Notification Item
struct NotificationItem: Identifiable {
    let id: UUID = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let time: String
}

// MARK: - Notification Section
struct NotificationSection: Identifiable {
    let id: UUID = UUID()
    let heading: String
    var items: [NotificationItem]
}
