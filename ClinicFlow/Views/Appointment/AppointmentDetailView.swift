//
//  AppointmentDetailView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-04.
//

import SwiftUI

struct AppointmentDetailsView: View {
    let booking: AppointmentBooking
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tabManager: TabBarViewModel
    @State private var showCheckInPopup = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: - Header
                Text("Appointment Details")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 80)
                    .padding(.top, 6)
                
                // MARK: - Consultation Details
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Consultation Details")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top, 20)
                        
                        HStack(spacing: 16) {
                            Image(booking.doctor.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 110)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(booking.doctor.name)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Text(booking.doctor.speciality)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - Appointment Number
                    HStack {
                        Text("Appointment Number")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                        
                        Text(": ")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        Text(booking.appointmentNumber)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(hex: "0930A6"))
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 24)
                    
                    // MARK: - Appointment Info Card
                    VStack(alignment: .leading, spacing: 0) {
                        AppointmentInfoRow(label: "Date", value: formatDate(booking.date))
                        Divider()
                        AppointmentInfoRow(label: "Estimated Time", value: booking.estimatedTime)
                        Divider()
                        AppointmentInfoRow(label: "Doctor Arrival Time", value: booking.doctorArrivalTime)
                        Divider()
                        AppointmentInfoRow(label: "Room Number", value: booking.roomNumber)
                    }
                    .padding(.bottom, 30)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                            )
                    )
                    .padding(.horizontal, 24)
                    
                    // MARK: - Patient Details
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Patient Details")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top, 20)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            AppointmentInfoRow(label: "Patient Name", value: booking.patient.name)
                            Divider()
                            AppointmentInfoRow(label: "Patient Age", value: "\(booking.patient.age) yrs")
                            Divider()
                            AppointmentInfoRow(label: "Contact Number", value: booking.patient.contactNumber)
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white)
                                )
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - Check In Button
                    Button(action: {
                        showCheckInPopup = true
                        tabManager.isTabBarHidden = true
                    }) {
                        Text("Check In")
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
                    .padding(.top, 60)
                    .padding(.bottom, 60)
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
                    .padding(.leading, 30)
                    .padding(.top, 0)
                    
                    Spacer()
                }
                Spacer()
            }
            
            // MARK: - CheckIn Confirm Popup
            if showCheckInPopup {
                CheckInConfirmationPopup(
                    date: formatDate(booking.date),
                    time: booking.estimatedTime,
                    doctorName: booking.doctor.name,
                    roomNumber: booking.roomNumber,
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
                        .padding(.trailing, 0)
                        .padding(.top, 0)
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            tabManager.activeTab = .none
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

// MARK: - Renamed to AppointmentInfoRow to avoid redeclaration conflict
struct AppointmentInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 150, alignment: .leading)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(.gray)
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    AppointmentDetailsView(
        booking: AppointmentBooking(
            appointmentNumber: "#25",
            doctor: Doctor.sampleDoctors[0],
            patient: Patient.samplePatients[0],
            date: Date(),
            time: "10.30 AM",
            estimatedTime: "01.30 PM",
            doctorArrivalTime: "10.30 AM",
            roomNumber: "F1-307"
        )
    )
    .environmentObject(TabBarViewModel())
}
