//
//  HomeView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showNotifications = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(hex: "FFFFFF")
                    .ignoresSafeArea()
                
                // Content
                VStack(alignment: .leading, spacing: 0) {
                    Text("Hi, Kaveen")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading, 25)
                        .padding(.top, 15)
                    
                    Text("Welcome to Clinic Flow")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.leading, 25)
                        .padding(.top, 5)
                    
                    Text("What would you like to do today?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.leading, 25)
                        .padding(.top, 30)
                    
                    // MARK: Service Grid
                    ServiceGrid()
                        .padding(.top, 20)
                        .padding(.leading, 24)
                        .padding(.bottom, 30)
                    
                    // MARK: Visit Journey Banner
                    Image("banner")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 10)
                        .padding(.bottom, 16)
                    
                    // MARK: Upcoming Appointment
                    Text("Upcoming Appointment")
                        .font(.headline)
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
                        print("Check In tapped")
                    }
                    .padding(.top, 16)
                    
                    // MARK: Top Doctors
                    Text("Top Doctors")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.leading, 24)
                        .padding(.top, 30)
                }
                
                // MARK: Notification button
                NotificationButton()
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
