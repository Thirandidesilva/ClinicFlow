//
//  BookAppointmentView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-02.
//

import SwiftUI

struct BookAppointmentView: View {
    @StateObject private var viewModel: BookAppointmentViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showSuccessMessage = false
    @State private var navigateToDetails = false
    
    init(doctor: Doctor) {
        _viewModel = StateObject(wrappedValue: BookAppointmentViewModel(doctor: doctor))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 30) {
                
                // MARK: - Header
                Text("Book Appointment")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 80)
                    .padding(.top, 6)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: - Enter Patient Details
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Enter Patient Details")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                        
                        PatientDropdownField(
                            selectedPatient: $viewModel.selectedPatient,
                            patients: viewModel.patients,
                            onAddNewPatient: {
                                viewModel.addNewPatient()
                            }
                        )
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 25)
                    
                    // MARK: - Select Date
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Date")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.horizontal, 30)
                            .padding(.top, 30)
                        
                        CustomCalendar()
                            .frame(maxWidth: .infinity)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    // MARK: - Select Time
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Time")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.top, 30)
                            .padding(.horizontal, 30)
                        
                        SelectTimeCard(selectedTime: $viewModel.selectedTime)
                    }
                    
                    // MARK: - Book Appointment Button
                    VStack(spacing: 16) {
                        Button(action: {
                            if viewModel.validateBooking() {
                                viewModel.bookAppointment()
                                showSuccessMessage = true
                            }
                        }) {
                            Text("Book Appointment")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color(hex: "0930A6"))
                                )
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 60)
                    .padding(.bottom, 60)
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
        .alert("Error", isPresented: $viewModel.showValidationError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.validationMessage)
        }
        .alert("Success", isPresented: $showSuccessMessage) {
            Button("OK", role: .none) {
                navigateToDetails = true
            }
        } message: {
            Text("Appointment booked successfully!")
        }
        .navigationDestination(isPresented: $viewModel.navigateToAddPatient) {
            AddPatientView(
                onPatientAdded: { newPatient in
                    viewModel.patients.append(newPatient)
                    viewModel.selectedPatient = newPatient
                },
                doctor: viewModel.doctor
            )
        }
        .navigationDestination(isPresented: $navigateToDetails) {
            AppointmentDetailsView(booking: AppointmentBooking(
                appointmentNumber: "#\(Int.random(in: 10...99))",
                doctor: viewModel.doctor,
                patient: viewModel.selectedPatient ?? Patient.samplePatients[0],
                date: Date(),
                time: viewModel.selectedTime,
                estimatedTime: "01.30 PM",
                doctorArrivalTime: "10.30 AM",
                roomNumber: "F1-307"
            ))
        }
    }
}

#Preview {
    BookAppointmentView(doctor: Doctor.sampleDoctors[0])
        //.environmentObject(TabBarManager())
}
