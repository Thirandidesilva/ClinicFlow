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
    //@EnvironmentObject var tabManager: TabBarManager
    
    init(doctor: Doctor) {
        _viewModel = StateObject(wrappedValue: DoctorDetailViewModel(doctor: doctor))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
//            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header Title
                    Text("Doctor Details")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: - Doctor Info Header
                    DoctorInfoHeader(doctor: viewModel.doctor)
                        .padding(.horizontal, 24)
                    
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
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text(viewModel.doctor.about)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .lineSpacing(4)
                        
                        Button(action: {}) {
                            Text("view more")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(hex: "0930A6"))
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - Working Time
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Working Time")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("\(viewModel.doctor.workingTime) 8.00 AM to 8.00 PM")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - Reviews Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Reviews")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.showAllReviews.toggle()
                            }) {
                                Text("See All")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "0930A6"))
                            }
                        }
                        
                        ForEach(viewModel.getDisplayReviews()) { review in
                            ReviewCard(review: review)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 140)
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
            
            // MARK: - Notification Button (Top Right)
            VStack {
                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.trailing, 24)
                        .padding(.top, 60)
                }
                Spacer()
            }
            
            // MARK: - Book Button
            VStack {
                Spacer()
                
                Button(action: {
                    viewModel.bookAppointment()
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
                .padding(.top, 0)
            }
        }
//        .overlay(alignment: .bottom) {
//            CustomTabBar(activeTab: $tabManager.activeTab)
//                .padding(.bottom, -20)
//                .shadow(color: .black.opacity(0.15), radius: 10)
//        }
        .navigationBarHidden(true)
    }
}

#Preview {
    DoctorDetailView(doctor: Doctor.sampleDoctors[0])
        //.environmentObject(TabBarManager())
}
