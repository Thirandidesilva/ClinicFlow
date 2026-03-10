//
//  PharmacyView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct PharmacyView: View {
    @StateObject private var viewModel = PharmacyViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var navigateToHome = false
    @EnvironmentObject var tabManager: TabBarViewModel
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            //ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Queue Status")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Text("PHARMACY")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 0)
                    .padding(.leading, 55)
                    
                    // MARK: - Notification Message
                    ScrollView {
                    HStack(spacing: 10) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "0930A6").opacity(0.8))
                        
                        Text("You will receive an automatic notification when your turn is approaching")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "0930A6").opacity(0.8))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray.opacity(0.2), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // MARK: - Pharmacy Progress Steps
                    PharmacyProgressSteps(steps: viewModel.steps)
                    
                    // MARK: - Pharmacy Token Card
                    PharmacyTokenCard(
                        token: viewModel.pharmacyToken,
                        status: viewModel.currentStatus,
                        estimatedTime: viewModel.estimatedReadyTime,
                        isCompleted: viewModel.isCompleted
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    // MARK: - Complete Pharmacy Button
                        
                    Button(action: {
                        viewModel.completePharmacy()
                        tabManager.activeTab = .home
                        tabManager.popToRoot()
                    }) {
                        Text("Complete Pharmacy")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.isCompleted ? Color(hex: "0930A6") : Color.gray.opacity(0.3))
                            )
                    }
                    .disabled(!viewModel.isCompleted)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    
                    // MARK: - Cancel Button
                        
                    Button(action: {
                        tabManager.isTabBarHidden = true
                        viewModel.requestCancelToken()
                    }) {
                        Text("Cancel Token")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(hex: "E01F20"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(hex: "E01F20"), lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    .padding(.bottom, 60)
                }
            }
            .scrollIndicators(.hidden)
            
            // MARK: - Back Button
            
            VStack {
                HStack {
                    Button(action: {
                        tabManager.activeTab = .home
                        tabManager.popToRoot()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(
                                Circle()
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.1), radius: 4)
                            )
                    }
                    .padding(.leading, 24)
                    .padding(.top, 0)
                    
                    Spacer()
                }
                Spacer()
            }
            
            // MARK: - Notification Button
            
            VStack {
                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.trailing, 0)
                        .padding(.top, 0)
                }
                Spacer()
            }
            
            // MARK: - Cancel Token Popup
            
            if viewModel.showCancelPopup {
                CancelTokenPopup(
                    onCancel: {
                        viewModel.cancelToken()
                        tabManager.isTabBarHidden = false
                        tabManager.activeTab = .home
                        tabManager.popToRoot()
                    },
                    onDismiss: {
                        tabManager.isTabBarHidden = false
                        viewModel.showCancelPopup = false
                    }
                )
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            tabManager.activeTab = .none
        }
        .alert("Medicines Ready!", isPresented: $viewModel.showCompletedAlert) {
            Button("OK", role: .none) {
                viewModel.showCompletedAlert = false
            }
        } message: {
            Text("Your medicines are ready to collect!")
        }
    }
}

#Preview {
    PharmacyView()
        .environmentObject(TabBarViewModel())
}
