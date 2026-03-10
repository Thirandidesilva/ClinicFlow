//
//  AccountView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = AccountViewModel()
    @State private var showLogoutSheet = false
    @State private var navigateToSetup = false
    @State private var showEditName = false
    @State private var showEditPhone = false
    @State private var showEditEmail = false

    var body: some View {
        VStack(spacing: 0) {

                // MARK: Fixed Header
                ZStack(alignment: .trailing) {
                    Color(hex: "F5F5F5")

                    HStack {
                        Text("My Profile")
                            .font(.title2)
                            .fontWeight(.bold)
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
                                Button { showEditName = true } label: {
                                    InfoRow(text: viewModel.fullName)
                                }
                                Divider().padding(.leading, 16)

                                Button { showEditPhone = true } label: {
                                    InfoRow(text: viewModel.phoneNumber)
                                }
                                Divider().padding(.leading, 16)

                                Button { showEditEmail = true } label: {
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
                        NavigationLink(value: NavigationRoute.healthRecords) {
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
                        Button(action: {
                            showLogoutSheet = true
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
            // MARK: Navigate to Setup after logout
            .navigationDestination(isPresented: $navigateToSetup) {
                SetupView()
            }
        // MARK: Edit Sheets
        .fullScreenCover(isPresented: $showEditName) {
            EditNameView(viewModel: EditNameViewModel(accountViewModel: viewModel))
        }
        .fullScreenCover(isPresented: $showEditPhone) {
            EditPhoneView(viewModel: EditPhoneViewModel(accountViewModel: viewModel))
        }
        .fullScreenCover(isPresented: $showEditEmail) {
            EditEmailView(viewModel: EditEmailViewModel(accountViewModel: viewModel))
        }
        // MARK: Logout Bottom Sheet
        .sheet(isPresented: $showLogoutSheet) {
            LogoutSheetView(
                onCancel: {
                    showLogoutSheet = false
                },
                onConfirm: {
                    showLogoutSheet = false
                    viewModel.logOut()
                    navigateToSetup = true
                }
            )
            .presentationDetents([.height(350)])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(28)
            .presentationBackground(Color.white)
        }
    }
}

// MARK: - Logout Bottom Sheet View
struct LogoutSheetView: View {
    let onCancel: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Icon
            Image("icn_plogout")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .padding(.top, 32)
                .padding(.bottom, 16)

            // MARK: Title
            Text("Logging Out ?")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "1A1AE6"))
                .padding(.bottom, 10)

            // MARK: Description
            Text("You'll lose your real-time updates after logging out. Are you sure you want to logout?")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 32)
                .padding(.bottom, 28)

            // MARK: Buttons
            HStack(spacing: 12) {
                // No, Don't logout
                Button(action: onCancel) {
                    Text("No, Don't logout")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(hex: "DDDDDD"), lineWidth: 1.5)
                        )
                }

                // Yes, Logout
                Button(action: onConfirm) {
                    Text("Yes, Logout")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(hex: "1A1AE6"))
                        .cornerRadius(30)
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity)
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


#Preview {
    AccountView()
}
