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
    @State private var showAllDoctors = false
    @StateObject private var viewModel = AppointmentViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tabManager: TabBarViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            
            ZStack(alignment: .topTrailing) {
                // Background
                Color(hex: "FFFFFF")
                    .ignoresSafeArea()
                
                // Contents
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("Location")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 80)
                        .padding(.top, 2)
                    
                    Text("Colombo 05, Sri Lanka")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.leading, 80)
                        .padding(.bottom, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        Text("Let's search for your Doctor")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading, -60)
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
                                }
                            }
                            .padding(.horizontal, 24)
                            .padding(.top, 30)
                        }
                        
                        // MARK: - Recent Consultations
                        HStack {
                            Text("Recent Consultations")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                showAllDoctors = true
                            }) {
                                Text("See All")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "0930A6"))
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        
                        // MARK: - Doctor Cards
                        VStack(spacing: 16) {
                            ForEach(viewModel.isSearching
                                    ? viewModel.filteredDoctors
                                    : (showAllDoctors
                                       ? Array(viewModel.recentConsultations.prefix(7))
                                       : Array(viewModel.recentConsultations.prefix(2)))
                            ) { doctor in
                                DoctorCard(doctor: doctor) {
                                    viewModel.bookAppointment(for: doctor)
                                }
                            }
                        }
                        .padding(.top, 16)
                    }
                }
                
                // MARK: - Back Button (Top Left)
                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
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
                        Spacer()
                    }
                    Spacer()
                }
                
                // MARK: - Notification Button (Top Right)
                VStack {
                    HStack {
                        Spacer()
                        NotificationButton()
                    }
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToSpecialtyTab) {
                if let specialty = selectedSpecialty {
                    SpecialtyTabView(preselectedSpecialty: specialty)
                }
            }
            
            // MARK: - Tab Bar
            CustomTabBar(activeTab: Binding(
                get: { .none },
                set: { newTab in
                    tabManager.activeTab = newTab
                    dismiss()
                }
            ))
            .shadow(color: .black.opacity(0.15), radius: 10)
            .padding(.bottom, 8)
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            tabManager.activeTab = .none
            tabManager.dismissSecondaryPage = { dismiss() }
        }
        .onDisappear {
            tabManager.dismissSecondaryPage = nil
        }
        .onChange(of: tabManager.popToRootTrigger) { _, _ in
            dismiss()
        }
    }
}

#Preview {
    AppointmentDashboardView()
        .environmentObject(TabBarViewModel())
}
