//
//  NotificationViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-03-01.
//

//
//  NotificationViewModel.swift
//  ClinicFlow
//
//  Created by M H T U De Silva
//

import SwiftUI
import Combine

class NotificationViewModel: ObservableObject {

    @Published var sections: [NotificationSection] = [
        NotificationSection(
            heading: "Today",
            items: [
                NotificationItem(
                    type: .blue,
                    title: "Lab Report is ready",
                    message: "Your lab report is ready to be collected.",
                    time: "8:50 AM"
                )
            ]
        ),
        NotificationSection(
            heading: "Yesterday",
            items: [
                NotificationItem(
                    type: .blue,
                    title: "Get Ready Your Turn is Near",
                    message: "Get ready! You are 1 patients away from your turn",
                    time: "9:40 AM"
                ),
                NotificationItem(
                    type: .blue,
                    title: "Get Ready Your Turn is Near",
                    message: "Get ready! You are 2 patients away from your turn",
                    time: "9:40 AM"
                ),
                NotificationItem(
                    type: .red,
                    title: "Doctor Delay",
                    message: "The doctor is running a little late and is expected at 10:30 AM.",
                    time: "8:40 AM"
                ),
                NotificationItem(
                    type: .blue,
                    title: "Reminder",
                    message: "Today You have an appointment with Dr. Patel at 10.15 AM",
                    time: "7:00 AM"
                )
            ]
        )
    ]

    func markAllRead(in section: NotificationSection) {
        // Future: mark all as read logic
    }
}
