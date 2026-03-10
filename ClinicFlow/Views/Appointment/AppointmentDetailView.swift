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
    @State private var showCheckInPopup = false
    @State private var goToConsultation = false
    //@State private var showCheckInPopup = false
    //@EnvironmentObject var tabManager: TabBarManager
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            //ScrollView(.vertical, showsIndicators: false) {
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
                    
                    // MARK: - Appointment Info Card
                    VStack(alignment: .leading, spacing: 0) {
                        InfoRow(label: "Date", value: formatDate(booking.date))
                        Divider()
                        InfoRow(label: "Estimated Time", value: booking.estimatedTime)
                        Divider()
                        InfoRow(label: "Doctor Arrival Time", value: booking.doctorArrivalTime)
                        Divider()
                        InfoRow(label: "Room Number", value: booking.roomNumber)
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
                            InfoRow(label: "Patient Name", value: booking.patient.name)
                            Divider()
                            InfoRow(label: "Patient Age", value: "\(booking.patient.age) yrs")
                            Divider()
                            InfoRow(label: "Contact Number", value: booking.patient.contactNumber)
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
                        // Navigate to check-in or home
                        showCheckInPopup = true
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
                //MARK: - Cancel Button
                    
                    
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
                    .padding(.leading, 30)
                    .padding(.top, 0)
                    
                    Spacer()
                }
                Spacer()
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
                        goToConsultation = true
                    },
                    onCancel: {
                        showCheckInPopup = false
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
//        .overlay(alignment: .bottom) {
//            CustomTabBar(activeTab: $tabManager.activeTab)
//                .padding(.bottom, -20)
//                .shadow(color: .black.opacity(0.15), radius: 10)
//        }
        .navigationBarHidden(true)
        
        .navigationDestination(isPresented: $goToConsultation) {
            ConsultationView()
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}

struct InfoRow: View {
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
            time: "Morning",
            estimatedTime: "01.30 PM",
            doctorArrivalTime: "10.30 AM",
            roomNumber: "F1-307"
        )
    )
    //.environmentObject(TabBarManager())
}
