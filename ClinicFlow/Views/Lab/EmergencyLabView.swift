//
//  EmergencyLabView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct EmergencyLabView: View {
    @StateObject private var viewModel = LabViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tabManager: TabBarViewModel
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                
                // MARK: - Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Your Queue Status")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Text("EMERGENCY LAB")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 7)
                .padding(.leading, 70)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: - Notification Message
                    
                    HStack(spacing: 10) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "0930A6").opacity(0.8))
                        
                        Text("You will receive an automatic notification when your report is ready.")
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
                    .padding(.horizontal, 35)
                    .padding(.top, 10)
                    
                    // MARK: - Emergency Banner
                    
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "waveform.path.ecg")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(hex: "E01F20"))
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Group {
                                Text("This emergency lab test has been ") +
                                Text("requested by your doctor")
                                    .fontWeight(.bold) +
                                Text(".")
                            }
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "E01F20"))
                            
                            Text("Please proceed as directed by your care team.")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "E01F20"))
                        }
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "E01F20").opacity(0.06))
                    )
                    .overlay(alignment: .leading) {
                        Rectangle()
                            .fill(Color(hex: "E01F20"))
                            .frame(width: 4)
                            .cornerRadius(2)
                    }
                    .padding(.horizontal, 35)
                    .padding(.top, 10)
                    
                    // MARK: - Lab Progress Steps
                    
                    EmergencyProcessCard(steps: viewModel.steps)
                        .padding(.top, 10)
                    
                    // MARK: - Lab Token Card
                    
                    EmergencyTokenCard(
                        token: viewModel.emergencyLabToken,
                        status: viewModel.currentStatus,
                        estimatedTime: viewModel.estimatedReadyTime,
                        isCompleted: viewModel.isCompleted
                    )
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    
                    // MARK: - Request Info
                    
                    RequestInfoCard(
                        reasonTitle: "REASON FOR EMERGENCY",
                        reasonDescription: "Suspected acute infection - rapid CBC required",
                        departmentTitle: "DEPARTMENT/WARD",
                        departmentName: "Internal Medicine — Ward 3B"
                    )
                    .padding(.horizontal, 30)
                    
                    // MARK: - Complete Lab Button
                    
                    Button(action: {
                        viewModel.completeLab()
                        tabManager.activeTab = .home
                        dismiss()
                    }) {
                        Text("Mark Emergency Lab Complete")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(viewModel.isCompleted ? Color(hex: "E01F20") : Color.gray.opacity(0.3))
                            )
                    }
                    .disabled(!viewModel.isCompleted)
                    .padding(.horizontal, 40)
                    .padding(.top, 50)
                    .padding(.bottom, 60)
                }
            }
            
            // MARK: - Back Button
            
            VStack {
                HStack {
                    Button(action: {
                        tabManager.activeTab = .home
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
                    .padding(.leading, 35)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                Spacer()
            }
            
            // MARK: - Notification Button
            
            VStack {
                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            tabManager.activeTab = .none
            tabManager.dismissSecondaryPage = { dismiss() }
        }
        .onDisappear {
            tabManager.dismissSecondaryPage = nil
        }
        .alert("Report is Ready!", isPresented: $viewModel.showCompletedAlert) {
            Button("OK", role: .none) {
                viewModel.showCompletedAlert = false
            }
        } message: {
            Text("Your Emeregency lab report is ready to collect!")
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    EmergencyLabView()
        .environmentObject(TabBarViewModel())
}
