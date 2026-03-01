//
//  NotificationView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-25.
//

//
//  NotificationView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva
//

import SwiftUI

struct NotificationView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Fixed Header
            ZStack {
                Color.white
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    Text("Notifications")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .frame(height: 60)

            // MARK: Scrollable Content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.sections) { section in
                        NotificationSectionView(
                            section: section,
                            onMarkAllRead: { viewModel.markAllRead(in: section) }
                        )
                    }
                }
                .padding(.top, 8)
            }
            .safeAreaInset(edge: .bottom) { Color.clear.frame(height: 90) }
            .background(Color.white)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

// MARK: - Section View
struct NotificationSectionView: View {
    let section: NotificationSection
    let onMarkAllRead: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Section Header
            HStack {
                Text(section.heading)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: onMarkAllRead) {
                    Text("Mark All Read")
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "1A1AE6"))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 12)

            // Notification Items
            VStack(spacing: 0) {
                ForEach(section.items) { item in
                    NotificationRow(item: item)
                    if item.id != section.items.last?.id {
                        Divider()
                            .padding(.leading, 72)
                    }
                }
            }
        }
    }
}

// MARK: - Notification Row
struct NotificationRow: View {
    let item: NotificationItem

    var iconName: String {
        item.type == .blue ? "icn_notblue" : "icn_notred"
    }

    var iconBg: Color {
        item.type == .blue ? Color(hex: "1A1AE6") : Color(hex: "E53935")
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {

            // Icon — filled circle with white bell on top
            ZStack {
                Circle()
                    .fill(iconBg)
                    .frame(width: 44, height: 44)
                Image(systemName: "bell.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }

            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text(item.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Spacer()
                    Text(item.time)
                        .font(.caption)
                        .foregroundColor(Color(hex: "AAAAAA"))
                }
                .padding(.top, 2)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color.white)
    }
}

#Preview {
    NavigationStack {
        NotificationView()
    }
}
