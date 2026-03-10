//
//  DoctorDetailView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct DoctorDetailView: View {
    @StateObject private var viewModel: DoctorDetailViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tabManager: TabBarViewModel
    
    init(doctor: Doctor) {
        _viewModel = StateObject(wrappedValue: DoctorDetailViewModel(doctor: doctor))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Fixed Header
                VStack(alignment: .leading, spacing: 0) {
                    Text("Doctor Details")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 80)
                        .padding(.top, 6)
                        .padding(.bottom, 16)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                
                // MARK: - Scrollable Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        // MARK: - Doctor Info Header
                        DoctorInfoHeader(doctor: viewModel.doctor)
                            .padding(.horizontal, 24)
                            .padding(.top, 20)
                        
                        // MARK: - Stats Row
                        DoctorStatsRow(
                            patientsCount: viewModel.doctor.patientsCount,
                            experienceYears: viewModel.doctor.experienceYears,
                            ratingsCount: viewModel.doctor.ratingsCount,
                            reviewsCount: viewModel.doctor.reviewsCount
                        )
                        .padding(.horizontal, 24)
                        
                        // MARK: - About Doctor
                        VStack(alignment: .leading, spacing: 12) {
                            Text("About doctor")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text(viewModel.doctor.about)
                                .font(.system(size: 15))
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                            
                            Button(action: {}) {
                                Text("view more")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(hex: "0930A6"))
                            }
                        }
                        .padding(.leading, 24)
                        .padding(.bottom, 10)
                        
                        // MARK: - Working Time
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Working Time")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Text("\(viewModel.doctor.workingTime) 8.00 AM to 8.00 PM")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal, 24)
                        
                        // MARK: - Reviews Section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Reviews")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.showAllReviews.toggle()
                                }) {
                                    Text("See All")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color(hex: "0930A6"))
                                }
                            }
                            
                            ForEach(viewModel.getDisplayReviews()) { review in
                                ReviewCard(review: review)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                    }
                    .padding(.top, 20)
                    
                    // MARK: - Book Button
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            if viewModel.isFirstTimeBooking() {
                                tabManager.navigationPath.append(NavigationRoute.addPatient(viewModel.doctor))
                            } else {
                                tabManager.navigationPath.append(NavigationRoute.bookAppointment(viewModel.doctor))
                            }
                        }) {
                            Text("Book")
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
                        .padding(.bottom, 60)
                        .padding(.top, 60)
                        .background(
                            LinearGradient(
                                colors: [Color.white.opacity(0.5), Color.white],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: 100)
                        )
                    }
                }
            }
            
            // MARK: - Back Button (Top Left)
            VStack {
                HStack {
                    Button(action: {
                        if !tabManager.navigationPath.isEmpty {
                            tabManager.navigationPath.removeLast()
                        }
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
    }
}

#Preview {
    DoctorDetailView(doctor: Doctor.sampleDoctors[0])
}
