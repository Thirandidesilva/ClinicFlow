//
// SetupView.swift
// ClinicFlow
//
// Created by Thirandi De Silva on 2026-02-20
//

import SwiftUI

struct SetupView: View {
    @StateObject private var viewModel = SetupViewModel()
    var onNavigateToHome: () -> Void = {}
    @FocusState private var isEmailFocused: Bool
    @State private var goToTabBar = false

    var body: some View {

        // MARK: - Direct swap to TabBarNav
        if goToTabBar {
            TabBarNav()

        } else {
            ZStack {
                // Background
                Color(red: 0.98, green: 0.98, blue: 0.99)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden(true)

                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 16) {
                        Text("Let's Set You Up")
                            .font(.system(size: 36, weight: .bold, design: .default))
                            .tracking(-0.5)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Text("Almost ready to begin")
                            .font(.system(size: 17, weight: .regular, design: .default))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                    .padding(.top, 50)
                    .padding(.bottom, 40)

                    // Illustration
                    VStack {
                        Image("img_setphone")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 140)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 40)

                    // Email Input
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            Image("icn_email")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)

                            TextField("Email", text: $viewModel.emailInput)
                                .focused($isEmailFocused)
                                .font(.system(size: 16, weight: .regular, design: .default))
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(
                                    isEmailFocused ? Color(red: 0.2, green: 0.4, blue: 1.0) : Color(red: 0.9, green: 0.9, blue: 0.95),
                                    lineWidth: isEmailFocused ? 2 : 1
                                )
                        )

                        if !viewModel.verificationError.isEmpty {
                            Text(viewModel.verificationError)
                                .font(.system(size: 13, weight: .regular, design: .default))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 8)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                    // Send OTP Button
                    Button(action: {
                        viewModel.sendOTP()
                    }) {
                        Text("Send OTP")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 58)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.1, green: 0.3, blue: 0.85),
                                        Color(red: 0.15, green: 0.35, blue: 0.95)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)

                    // Sign In Options Text
                    Text("or Sign in using")
                        .font(.system(size: 15, weight: .regular, design: .default))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 20)

                    // Social Sign In Buttons
                    VStack(spacing: 16) {
                        // Google Button
                        Button(action: {
                            viewModel.signInWithGoogle {
                                goToTabBar = true  // ← updated
                            }
                        }) {
                            HStack(spacing: 14) {
                                Image("icn_google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)

                                Text("Continue with Google")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.95), lineWidth: 1)
                            )
                        }

                        // Apple Button
                        Button(action: {
                            viewModel.signInWithApple {
                                goToTabBar = true  
                            }
                        }) {
                            HStack(spacing: 14) {
                                Image("icn_apple")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)

                                Text("Continue with Apple")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(.black)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.white)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(red: 0.9, green: 0.9, blue: 0.95), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }

                // Verify Modal
                if viewModel.showVerifyModal {
                    VerifyModalView(viewModel: viewModel) {
                        goToTabBar = true
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
}

#Preview {
    SetupView()
}
