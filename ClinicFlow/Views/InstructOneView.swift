//
//  InstructOneView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-24.
//

import SwiftUI

// MARK: - InstructOneView
// This single view handles all 5 instruction pages.
// Only the image and text change per page — driven by OnboardingViewModel.

struct InstructOneView: View {

    @StateObject private var viewModel = OnboardingViewModel()

    private let buttonColor = Color(red: 0.18, green: 0.32, blue: 0.87)

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 0) {

                    // MARK: - Top Bar
                    HStack {
                        PageIndicatorView(
                            currentIndex: viewModel.currentIndex,
                            totalPages: viewModel.totalPages
                        )

                        Spacer()

                        Button {
                            viewModel.skip()
                        } label: {
                            Text("Skip")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(buttonColor)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                    Spacer()

                    // MARK: - Illustration
                    Image(viewModel.currentPage.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280, height: 280)
                        .transition(.opacity.combined(with: .scale(scale: 0.95)))
                        .id(viewModel.currentPage.id) // forces transition on change
                        .padding(.bottom, 40)

                    // MARK: - Text
                    VStack(spacing: 12) {
                        Text(viewModel.currentPage.title)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .transition(.opacity)
                            .id("title_\(viewModel.currentPage.id)")

                        Text(viewModel.currentPage.subtitle)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(Color(red: 0.45, green: 0.45, blue: 0.45))
                            .multilineTextAlignment(.center)
                            .transition(.opacity)
                            .id("subtitle_\(viewModel.currentPage.id)")
                    }
                    .padding(.horizontal, 32)

                    Spacer()

                    // MARK: - Next Button
                    Button {
                        viewModel.goToNext()
                    } label: {
                        Text("Next")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(buttonColor)
                            )
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 48)
                }
            }
            // MARK: - Navigation to SetupView
            .navigationDestination(isPresented: $viewModel.navigateToSetup) {
                SetupView()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    InstructOneView()
}
