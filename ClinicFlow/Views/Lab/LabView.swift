//
//  LabView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct LabView: View {
    @StateObject private var viewModel = LabViewModel()
    @Environment(\.dismiss) var dismiss
    //@EnvironmentObject var tabManager: TabBarManager
    @State private var navigateToHome = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Queue Status")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        Text("LABORTARY")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 0)
                    .padding(.leading, 55)
                    
                    // MARK: - Notification Message
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
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    
                    // MARK: - Lab Progress Steps
                    LabProgressCard(steps: viewModel.steps)
                    
                    // MARK: - Preparation Instructions
                    PreparationInstructionCard(instructions: [
                        PreparationInstruction(
                            icon: "scissors",
                            text: "Please fast for 8 hours prior to your test. No food or drinks (except water) after midnight."
                        ),
                        PreparationInstruction(
                            icon: "doc.text",
                            text: "Bring any relevant medical reports or referral letters"
                        )
                    ])
                    .padding(.horizontal, 40)
                        
                    
                    // MARK: - Lab Token Card
                    LabTokenCard(
                        token: viewModel.labToken,
                        status: viewModel.currentStatus,
                        estimatedTime: viewModel.estimatedReadyTime,
                        isCompleted: viewModel.isCompleted
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    // MARK: - Complete Lab Button
                    Button(action: {
                        viewModel.completeLab()
                        navigateToHome = true
                    }) {
                        Text("Complete Labortary")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            //.padding(.horizontal, 60)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.isCompleted ? Color(hex: "0930A6") : Color.gray.opacity(0.3))
                            )
                    }
                    .disabled(!viewModel.isCompleted)
                    .padding(.horizontal, 50)
                    .padding(.top, 20)
                    
                    // MARK: - Cancel Button
                    Button(action: {
                        viewModel.requestCancelToken()
                    }) {
                        Text("Cancel Token")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(hex: "E01F20"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill( Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color(hex: "E01F20"), lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 50)
                }
            }
            
            // MARK: - Back Button (Top Left)
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
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
            
            // MARK: - Notification Button (Top Right)
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
                        navigateToHome = true
                    },
                    onDismiss: {
                        viewModel.showCancelPopup = false
                    }
                )
            }
        }
//        .overlay(alignment: .bottom) {
//            CustomTabBar(activeTab: $tabManager.activeTab)
//                .padding(.bottom, -20)
//                .shadow(color: .black.opacity(0.15), radius: 10)
//        }
        .navigationBarHidden(true)
        .alert("Report is Ready!", isPresented: $viewModel.showCompletedAlert) {
            Button("OK", role: .none) {
                viewModel.showCompletedAlert = false
            }
        } message: {
            Text("Your lab report is ready to collect!")
        }
        .navigationDestination(isPresented: $navigateToHome) {
            HomeView()
        }
    }
}

#Preview {
    LabView()
        //.environmentObject(TabBarManager())
}
