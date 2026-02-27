//
//  EditPhoneView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI

struct EditPhoneView: View {
    @ObservedObject var viewModel: EditPhoneViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // MARK: Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }

                    Text("Phone Number")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 8)

                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 24)

                // MARK: Description
                Text("You will use this number to get notifications, sign in and recover your account.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)

                // MARK: Phone Number Field
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)

                    TextField("Phone Number", text: $viewModel.phoneNumber)
                        .keyboardType(.phonePad)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(hex: "DDDDDD"), lineWidth: 1)
                        )
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                }
                .padding(.bottom, 40)

                // MARK: Update Button
                Button(action: {
                    viewModel.updatePhone()
                    dismiss()
                }) {
                    Text("Update")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            viewModel.isFormValid
                            ? Color(hex: "1A1AE6")
                            : Color(hex: "AAAAAA")
                        )
                        .cornerRadius(30)
                }
                .disabled(!viewModel.isFormValid)
                .padding(.horizontal, 24)

                Spacer()
            }

            // MARK: Notification Button
            NotificationButton()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    EditPhoneView(viewModel: EditPhoneViewModel(accountViewModel: AccountViewModel()))
}
