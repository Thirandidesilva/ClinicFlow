//
//  ConsultationView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct ConsultationView: View {
    @StateObject private var viewModel = ConsultationViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tabManager: TabBarViewModel
    
    var onComplete: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: - Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your Queue Status")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Text("CONSULTATION")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 0)
                .padding(.leading, 55)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
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
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    // MARK: - Queue Number Token
                    VStack(spacing: 16) {
                        Text("Your Queue Number")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        ZStack {
                            Circle()
                                .stroke(Color(hex: "0930A6").opacity(0.2), lineWidth: 2)
                                .frame(width: 120, height: 120)
                            
                            Text(viewModel.myToken)
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(Color(hex: "0930A6"))
                        }
                        
                        HStack(spacing: 4) {
                            Text("Estimated Consultation Time:")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text("\(viewModel.getEstimatedConsultationTime())")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .padding(.horizontal, 24)
                    .padding(.top, 10)
                    .padding(.bottom, 30)

                    // MARK: - Queue Progress Card
                    QueueProgressCard(
                        queueItems: viewModel.queueItems,
                        estimatedWait: viewModel.estimatedWaitTime,
                        aheadOfYou: String(format: "%02d", viewModel.peopleAhead)
                    )
                    
                    // MARK: - Complete Session Button
                    Button(action: {
                        tabManager.activeTab = .home
                        tabManager.popToRoot()
                    }) {
                        Text("Complete Session")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.isMyTurnCompleted ? Color(hex: "0930A6") : Color.gray.opacity(0.3))
                            )
                    }
                    .disabled(!viewModel.isMyTurnCompleted)
                    .padding(.horizontal, 40)
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                }
            }
            
            // MARK: - Back Button (Top Left)
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
                    .padding(.leading, 30)
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
        }
        .navigationBarHidden(true)
        
        .onAppear {
            tabManager.activeTab = .none
        }
        
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Queue Update"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ConsultationView()
        .environmentObject(TabBarViewModel())
}
