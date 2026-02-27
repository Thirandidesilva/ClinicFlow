//
//  SpecialityTabView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-26.
//

import SwiftUI

struct SpecialtyTabView: View {
    @StateObject private var viewModel = SpecialtyTabViewModel()
    @State private var showNotifications = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Header
                VStack(alignment: .leading, spacing: 24) {
                    Text("Find Your Specialist")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
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
            
            // MARK: - Notification Button
            NotificationButton()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SpecialtyTabView()
}
