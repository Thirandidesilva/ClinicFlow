//
//  ConsultationView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

//
//  ConsultationView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-27.
//

import SwiftUI

struct ConsultationView: View {
    @StateObject private var viewModel = ConsultationViewModel()
    //@Environment(\.dismiss) var dismiss
    //@EnvironmentObject var tabManager: TabBarManager
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white.ignoresSafeArea()
            
            // MARK: - Header Title
            VStack(alignment: .leading, spacing: 4) {
                Text("Your Queue Status")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Text("CONSULTATION")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Notification Message
                                        HStack(spacing: 10) {
                                            Image(systemName: "bell.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color(hex: "0930A6"))
                                                
                                            
                                            Text("You will receive an automatic notification when your turn is approaching")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color(hex: "0930A6"))
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        .padding(16)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                //.fill(Color(hex: "0930A6").opacity(0.1))
                                                .stroke(Color(hex: "0930A6").opacity(0.2), lineWidth: 1)
                                        )
                                        
                                        .padding(.horizontal, 15)
                                        .padding(.top, 90)
                    
                    // MARK: - Notification Message
//                    HStack(spacing: 12) {
//                        Image(systemName: "bell.fill")
//                            .font(.system(size: 16))
//                            .foregroundColor(Color(hex: "0930A6"))
//                            
//                        
//                        Text("You will receive an automatic notification when your turn is approaching")
//                            .font(.system(size: 16))
//                            .foregroundColor(Color(hex: "0930A6"))
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                    .padding(.horizontal, 60)
//
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(Color(hex: "0930A6").opacity(0.2), lineWidth: 1)
//                    )
//                    .padding(.horizontal, 24)
//                    .padding(.top, 90)
                    
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
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(hex: "FFFFFF"))
                    )
                    .padding(.horizontal, 24)
                    
                    // MARK: - Queue Progress Section (Combined Frame)
                    VStack(spacing: 20) {
                        // Queue Progress Header and Content
                        VStack(alignment: .leading, spacing: 16) {
                            // Header with Live indicator
                            HStack {
                                Text("Queue Progress")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                // Live indicator
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 8, height: 8)
                                    
                                    Text("Live")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.red.opacity(0.1))
                                )
                            }
                            
                            // Queue circles with connecting lines
                            HStack(spacing: 0) {
                                ForEach(Array(viewModel.queueItems.enumerated()), id: \.element.id) { index, item in
                                    QueueNumberCircle(number: item.number, status: item.status)
                                    
                                    // Connecting line (except for last item)
                                    if index < viewModel.queueItems.count - 1 {
                                        Rectangle()
                                            .fill(lineColor(for: item.status))
                                            .frame(height: 3)
                                            .frame(maxWidth: .infinity)
                                            .padding(.bottom, 30)
                                    }
                                }
                            }
                        }
                        
                        // Info Cards
                        HStack(spacing: 16) {
                            QueueInfoCard(
                                title: "estimated wait",
                                value: viewModel.estimatedWaitTime
                            )
                            
                            QueueInfoCard(
                                title: "ahead of you",
                                value: String(format: "%02d", viewModel.peopleAhead)
                            )
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(hex: "FFFFFF").opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color(hex: "0930A6").opacity(0.15), radius: 50, x: 1, y: 1)
                    .padding(.horizontal, 24)
                    
                    // MARK: - Complete Session Button
                    Button(action: {
                        viewModel.completeSession()
                    }) {
                        Text("Complete Session")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(hex: "0930A6"))
                            )
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 140)
                }
            }
            
            // MARK: - Notification Button (Top Right)
            VStack {
                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.trailing, 0)
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Queue Update"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationDestination(isPresented: $viewModel.showReviewPage) {
            ReviewView()
        }
    }
    
    // MARK: - Line Color Logic
    private func lineColor(for status: QueueItem.QueueStatus) -> Color {
        switch status {
        case .done:
            return Color(hex: "0930A6")
        case .current:
            return Color.green
        case .next, .user, .upcoming:
            return Color.gray.opacity(0.3)
        }
    }
}

#Preview {
    ConsultationView()
        //.environmentObject(TabBarManager())
}
