//
//  HealthRecordsView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-28
//

import SwiftUI

struct HealthRecordsView: View {
    @StateObject private var viewModel = HealthRecordViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // MARK: Fixed Header
                ZStack {
                    Color(hex: "F5F5F5")
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)
                        }
                        Text("Health Records")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.leading, 8)
                        Spacer()
                    }
                    .padding(.horizontal, 24)

                    HStack {
                        Spacer()
                        NotificationButton()
                            .padding(.trailing, 16)
                    }
                }
                .frame(height: 60)

                // MARK: Tab Toggle
                HStack(spacing: 0) {
                    TabToggleButton(
                        title: "Your Records",
                        isSelected: viewModel.selectedTab == .yourRecords
                    ) {
                        viewModel.selectedTab = .yourRecords
                    }
                    TabToggleButton(
                        title: "Other Records",
                        isSelected: viewModel.selectedTab == .otherRecords
                    ) {
                        viewModel.selectedTab = .otherRecords
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(hex: "F5F5F5"))

                // MARK: Content
                if viewModel.selectedTab == .yourRecords {
                    YourRecordsView(viewModel: viewModel)
                } else {
                    OtherRecordsView(viewModel: viewModel)
                }
            }
            .background(Color(hex: "F5F5F5").ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Tab Toggle Button
struct TabToggleButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .white : Color(hex: "888888"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isSelected ? Color(hex: "1A1AE6") : Color(hex: "EEEEEE"))
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HealthRecordsView()
}
