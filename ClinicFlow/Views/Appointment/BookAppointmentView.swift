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
    //@EnvironmentObject var tabManager: TabBarManager
    @State private var showSuccessMessage = false
    @State private var navigateToAddPatientForm = false
    
    init(doctor: Doctor) {
        _viewModel = StateObject(wrappedValue: BookAppointmentViewModel(doctor: doctor))
    }
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    Text("Book Appointment")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 80)
                        .padding(.top, 6)
                    
                    // MARK: - Enter Patient Details
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Enter Patient Details")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        PatientDropdownField(
                            selectedPatient: $viewModel.selectedPatient,
                            //showDropdown: $viewModel.showPatientDropdown,
                            patients: viewModel.patients,
                            onAddNewPatient: {
                                viewModel.addNewPatient()
                            }
                        )
                        .padding(.top, 10)
                        .padding(.horizontal, -4)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                    
                    // MARK: - Select Date
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Date")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 24)
                            .padding(.top, 30)
                        
                        CustomCalendar()
                            .padding(.top, 20)
                            .padding(.horizontal, 24)
                    }
                    
                    // MARK: - Select Time
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Time")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        SelectTimeCard(selectedTime: $viewModel.selectedTime)
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - Buttons
                    VStack(spacing: 16) {
                        Button(action: {
                            viewModel.bookAppointment()
                            if viewModel.validateBooking() {
                                showSuccessMessage = true
                            }
                        }) {
                            Text("Book Appointment")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color(hex: "0930A6"))
                                )
                        }
                        
//                        Button(action: {
//                            dismiss()
//                        }) {
//                            Text("Cancel")
//                                .font(.system(size: 18, weight: .semibold))
//                                .foregroundColor(Color(hex: "0930A6"))
//                                .frame(maxWidth: .infinity)
//                                .padding(.vertical, 16)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 30)
//                                        .stroke(Color(hex: "0930A6"), lineWidth: 2)
//                                        .background(
//                                            RoundedRectangle(cornerRadius: 30)
//                                                .fill(Color.white)
//                                        )
//                                )
//                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
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
//        .overlay(alignment: .bottom) {
//            CustomTabBar(activeTab: $tabManager.activeTab)
//                .padding(.bottom, -20)
//                .shadow(color: .black.opacity(0.15), radius: 10)
//        }
        .navigationBarHidden(true)
        .alert("Error", isPresented: $viewModel.showValidationError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.validationMessage)
        }
        .alert("Success", isPresented: $showSuccessMessage) {
            Button("OK", role: .none) {
                dismiss()
            }
        } message: {
            Text("Appointment booked successfully!")
        }
        .navigationDestination(isPresented: $viewModel.navigateToAddPatient) {
            AddPatientView()
        }
    }
}

#Preview {
    BookAppointmentView(doctor: Doctor.sampleDoctors[0])
        //.environmentObject(TabBarManager())
}
