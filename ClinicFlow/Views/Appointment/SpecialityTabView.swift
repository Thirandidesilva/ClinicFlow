//
//  SpecialityTabView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-26.
//

import SwiftUI

struct SpecialtyTabView: View {
    @StateObject private var viewModel: SpecialtyTabViewModel
    @State private var showNotifications = false
    @Environment(\.dismiss) var dismiss
    
    init(preselectedSpecialty: Specialty? = nil) {
        _viewModel = StateObject(wrappedValue: SpecialtyTabViewModel(preselectedSpecialty: preselectedSpecialty))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hi, Let's find Your Specialist")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .padding(.top, 60)
                    
                    // MARK: - Specialty Chips (Horizontal Scrollable Tabs)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.specialties) { specialty in
                                SpecialtyChip(
                                    specialty: specialty,
                                    isSelected: viewModel.selectedSpecialty.id == specialty.id
                                ) {
                                    viewModel.selectSpecialty(specialty)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    // MARK: - Search Bar
                    HStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "0930A6").opacity(0.7))
                        
                        TextField("Search", text: $viewModel.searchText)
                            .font(.system(size: 16))
                        
                        Button(action: viewModel.startVoiceSearch) {
                            Image(systemName: "mic.fill")
                                .foregroundColor(Color(hex: "0930A6").opacity(0.7))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal, 24)
                    
                    // MARK: - Doctor Count
                    Text(viewModel.getDoctorCount())
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                }
                
                // MARK: - Doctor List (Scrollable)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(viewModel.filteredDoctors) { doctor in
                            DoctorCard(doctor: doctor) {
                                viewModel.bookAppointment(for: doctor)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 120)
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
            
            // MARK: - Notification Button
            NotificationButton()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SpecialtyTabView()
}
