//
//  AccountView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = AccountViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // MARK: Fixed Header (stays pinned, never scrolls)
                ZStack(alignment: .trailing) {
                    Color(hex: "F5F5F5")

                    HStack {
                        Text("My Profile")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.horizontal, 24)

                    // Notification button pinned to right of header
                    HStack {
                        Spacer()
                        NotificationButton()
                            .padding(.trailing, 16)
                    }
                }
                .frame(height: 60)

                // MARK: Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // MARK: Profile Picture & Name
                        VStack(spacing: 8) {
                            ZStack(alignment: .bottomTrailing) {
                                Image("img_profile")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color(hex: "F5F5F5"), lineWidth: 3))

                                Circle()
                                    .fill(Color(hex: "1A1AE6"))
                                    .frame(width: 26, height: 26)
                                    .overlay(
                                        Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12, weight: .semibold))
                                    )
                                    .offset(x: 2, y: 2)
                            }

                            Text(viewModel.fullName)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)

                        // MARK: Your Information Section
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Your Information")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .padding(.top, 16)
                                .padding(.bottom, 8)

                            VStack(spacing: 0) {
                                NavigationLink(destination: EditNameView(viewModel: EditNameViewModel(accountViewModel: viewModel))) {
                                    InfoRow(text: viewModel.fullName)
                                }
                                Divider().padding(.leading, 16)

                                NavigationLink(destination: EditPhoneView(viewModel: EditPhoneViewModel(accountViewModel: viewModel))) {
                                    InfoRow(text: viewModel.phoneNumber)
                                }
                                Divider().padding(.leading, 16)

                                NavigationLink(destination: EditEmailView(viewModel: EditEmailViewModel(accountViewModel: viewModel))) {
                                    InfoRow(text: viewModel.email)
                                }
                            }
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                        .background(Color(hex: "F5F5F5"))

                        // MARK: Your Preferences Section
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Your Preferences")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                                .padding(.bottom, 8)

                            VStack(spacing: 0) {
                                InfoRow(text: "Languages (English)")
                                Divider().padding(.leading, 16)
                                InfoRow(text: "Additional Settings")
                                Divider().padding(.leading, 16)
                                InfoRow(text: "Add Emergency")
                            }
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        }
                        .background(Color(hex: "F5F5F5"))

                        // MARK: Health Records
                        NavigationLink(destination: HealthRecordsPlaceholderView()) {
                            HStack(spacing: 12) {
                                Image("icn_healthcross")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)

                                Text("Your Health Records")
                                    .font(.body)
                                    .foregroundColor(.primary)

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(hex: "AAAAAA"))
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                        }
                        .padding(.bottom, 24)

                        // MARK: Log Out Button
                        // Bottom padding of 100 ensures Log Out clears the fixed nav bar
                        Button(action: {
                            viewModel.logOut()
                        }) {
                            Text("Log Out")
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(hex: "1A1AE6"))
                                .cornerRadius(30)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 100)
                    }
                }
                .background(Color(hex: "F5F5F5"))
            }
            .background(Color(hex: "F5F5F5").ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Reusable Info Row
struct InfoRow: View {
    let text: String

    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(hex: "AAAAAA"))
                .font(.system(size: 13, weight: .semibold))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}

// MARK: - Health Records Placeholder
struct HealthRecordsPlaceholderView: View {
    var body: some View {
        Text("Navigate to Health Record Page")
            .navigationTitle("Health Records")
    }
}

#Preview {
    AccountView()
}
