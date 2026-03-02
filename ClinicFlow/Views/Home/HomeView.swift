//
//  HomeView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showNotifications = false
    @State private var goToConsultation = false
    
    @State private var goToAppointment = false
    @State private var goToPharmacy = false
    @State private var goToLab = false
    @State private var goToEmergencyLab = false
    
    
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
                .padding(.horizontal, 24)
                .padding(.top, 10)
                .padding(.bottom, 16)
                .background(Color.white)
                
                // MARK: - Scrollable Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("What would you like to do today?")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.leading, 24)
                        
                        // MARK: - Service Grid
                        ServiceGrid(
                            onAppointmentTap: {
                                goToAppointment = true
                            },
                            onPharmacyTap: {
                                goToPharmacy = true
                            },
                            onLabTap: {
                                goToLab = true
                            },
                            onEmergencyLabTap: {
                                goToEmergencyLab = true
                            }
                        )
                        .padding(.horizontal, 24)
                        
                        // MARK: - Visit Journey
                        Text("Visit Journey")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.leading, 24)
                        
                        VisitJoourney(
                            steps: ["Checkin", "Consultation", "Pharmacy", "Lab"],
                            currentStep: 1
                        )
                        
                        // MARK: - Upcoming Appointment
                        Text("Upcoming Appointment")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.leading, 24)
                        
                        UpcomingDrCard(
                            date: "1st of March 2026",
                            time: "1.30 PM",
                            doctorImage: "dr.elizabeth",
                            doctorName: "Elizabeth Blackwell",
                            speciality: "Cardiologist",
                            rating: 5.0,
                            reviewCount: 156
                        ) {
                            goToConsultation = true
                        }
                        
                        // MARK: - Top Doctors
                        Text("Top Doctors")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.leading, 24)
                        
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
            .navigationDestination(isPresented: $goToConsultation) {
                ConsultationView()
            }
            .navigationDestination(isPresented: $goToAppointment) {
                AppointmentDashboardView()
            }
            .navigationDestination(isPresented: $goToPharmacy) {
                PharmacyView()
            }
            .navigationDestination(isPresented: $goToLab) {
                LabView()
            }
            .navigationDestination(isPresented: $goToEmergencyLab) {
                EmergencyLabView()
            }
            
            // MARK: - Notification Button (Top Right)
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
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
