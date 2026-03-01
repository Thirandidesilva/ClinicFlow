//
//  AppointmentDashboardView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import SwiftUI

struct AppointmentDashboardView: View {
    
    @State private var showNotifications = false
    @State private var selectedSpecialty: Specialty? = nil
    @State private var navigateToSpecialtyTab = false
    @StateObject private var viewModel = AppointmentViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                // Background
                Color(hex: "FFFFFF")
                    .ignoresSafeArea()
                
                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("Location")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.leading, 30)
                            .padding(.top, 2)
                        
                        Text("Colombo 05, Sri Lanka")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.leading, 30)
                        
                        Text("Let's search for your Doctor")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading, 25)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                        
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
                        
                        // MARK: - Specialities
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Specialty.allSpecialties) { specialty in
                                    SpecialtyCard(
                                        specialty: specialty,
                                        isSelected: false
                                    ) {
                                        selectedSpecialty = specialty
                                        navigateToSpecialtyTab = true
                                    }
                                    .padding(.bottom, 0)
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 30)
                        }
                        
                        //MARK: - Recent Consultations
                        HStack {
                            Text("Recent Consultations")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedSpecialty = Specialty.allSpecialties.first
                                navigateToSpecialtyTab = true
                            }) {
                                Text("See All")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "0930A6"))
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        .padding(.bottom, 0)
                        
                        // MARK: - Doctor Cards
                        VStack(spacing: 16) {
                            ForEach(viewModel.isSearching
                                    ? viewModel.filteredDoctors
                                    : viewModel.recentConsultations) { doctor in
                                
                                DoctorCard(doctor: doctor) {
                                    viewModel.bookAppointment(for: doctor)
                                }
                            }
                        }
                        .padding(.top, 16)
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
                        .padding(.top, 60)
                        
                        Spacer()
                    }
                    Spacer()
                }
                
                // MARK: - Notification button
                NotificationButton()
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToSpecialtyTab) {
                if let specialty = selectedSpecialty {
                    SpecialtyTabView(preselectedSpecialty: specialty)
                }
            }
        }
    }
}

#Preview {
    AppointmentDashboardView()
}
