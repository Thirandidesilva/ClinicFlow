//
//  HomeView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var tabManager: TabBarViewModel
    
    @State private var showNotifications = false
    @State private var showCheckInPopup = false
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "FFFFFF")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Fixed Header (Non-scrollable)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hi, Kaveen")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("Welcome to Clinic Flow")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 10)
                .padding(.bottom, 16)
                .background(Color.white)
                
                // MARK: - Scrollable Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("What would you like to do today?")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                        // MARK: - Service Grid
                        ServiceGrid(
                            onAppointmentTap: {
                                tabManager.navigationPath.append(NavigationRoute.appointmentDashboard)
                            },
                            onPharmacyTap: {
                                tabManager.navigationPath.append(NavigationRoute.pharmacy)
                            },
                            onLabTap: {
                                tabManager.navigationPath.append(NavigationRoute.lab)
                            },
                            onEmergencyLabTap: {
                                tabManager.navigationPath.append(NavigationRoute.emergencyLab)
                            }
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 0)
                        
                        // MARK: - Visit Journey
//                        Text("Visit Journey")
//                            .font(.system(size: 18, weight: .medium))
//                            .padding(.leading, 30)
//                            .padding(.top, 20)
                        
                        VisitJourney(
                            steps: ["CheckIn", "Consultation", "Pharmacy", "Lab"],
                            currentStep: 1
                        )
                        .padding(.horizontal, 0)
                        .padding(.top, 20)
                        
                        // MARK: - Upcoming Appointment
                        Text("Upcoming Appointment")
                            .font(.system(size: 18, weight: .medium))
                            .padding(.leading, 30)
                            .padding(.top, 20)
                        
                        UpcomingDrCard(
                            date: "1st of March 2026",
                            time: "1.30 PM",
                            doctorImage: "dr.elizabeth",
                            doctorName: "Elizabeth Blackwell",
                            speciality: "Cardiologist",
                            rating: 5.0,
                            reviewCount: 156
                        ) {
                            tabManager.isTabBarHidden = true
                            showCheckInPopup = true
                        }
                        .padding(.top, -5)
                        
                        // MARK: - Top Doctors
                        Text("Top Doctors")
                            .font(.system(size: 18, weight: .medium))
                            .padding(.leading, 30)
                            .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Doctor.sampleDoctors.prefix(4)) { doctor in
                                    TopDrCard(doctor: doctor)
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.bottom, 60)
                    }
                }
            }
            
            // MARK: - CheckIn Confirm Popup
            if showCheckInPopup {
                CheckInConfirmationPopup(
                    date: "1st of March 2026",
                    time: "1.30 PM",
                    doctorName: "Elizabeth Blackwell",
                    roomNumber: "F1-307",
                    onCheckIn: {
                        showCheckInPopup = false
                        tabManager.isTabBarHidden = false
                        tabManager.navigationPath.append(NavigationRoute.consultation)
                    },
                    onCancel: {
                        showCheckInPopup = false
                        tabManager.isTabBarHidden = false
                    }
                )
            }
            
            // MARK: - Notification Button (Top Right)
            VStack {
                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.horizontal, 0)
                        .padding(.top, 0)
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(TabBarViewModel())
    }
}
