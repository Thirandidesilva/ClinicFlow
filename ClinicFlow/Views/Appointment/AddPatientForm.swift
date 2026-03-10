//
//  AddPatientView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct AddPatientView: View {
    @StateObject private var viewModel = AddPatientViewModel()
    @Environment(\.dismiss) var dismiss
    //@EnvironmentObject var tabManager: TabBarManager
    
    var onPatientAdded: ((Patient) -> Void)?
    var doctor: Doctor
    @State private var navigateToBooking = false
    @State private var newlyAddedPatient: Patient?
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            //ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Header
                    Text("Add New Patient")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 80)
                        .padding(.top, 6)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: - Personal Information
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Personal Information")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top, 20)
                            .padding(.leading, 5)
                        
                        FormSectionCard {
                            FormInputField(
                                label: "Full Name",
                                placeholder: "Enter Patient Name",
                                text: $viewModel.fullName
                            )
                            
                            Divider()
                            
                            FormInputField(
                                label: "Age",
                                placeholder: "Enter Age",
                                text: $viewModel.age,
                                keyboardType: .numberPad
                            )
                            
                            Divider()
                            
                            FormPickerField(
                                label: "Gender",
                                selection: $viewModel.gender,
                                options: viewModel.genderOptions
                            )
                        }
                        .padding(.top, 0)
                    }
                    .padding(.horizontal, 25)
                    
                    // MARK: - Contact Information
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Contact Information")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top, 20)
                            .padding(.leading, 5)
                        
                        FormSectionCard {
                            FormInputField(
                                label: "Contact Number",
                                placeholder: "+94 000 000 000",
                                text: $viewModel.contactNumber,
                                keyboardType: .phonePad
                            )
                            
                            Divider()
                            
                            FormInputField(
                                label: "Address",
                                placeholder: "Enter Address",
                                text: $viewModel.address
                            )
                        }
                        .padding(.top, 0)
                    }
                    .padding(.horizontal, 25)
                    
                    // MARK: - Vitals
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Vitals")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.top, 15)
                            .padding(.leading, 5)
                        
                        FormSectionCard {
                            FormPickerField(
                                label: "Weight",
                                selection: $viewModel.weight,
                                options: viewModel.weightOptions
                            )
                            
                            Divider()
                            
                            FormPickerField(
                                label: "Blood Type",
                                selection: $viewModel.bloodType,
                                options: viewModel.bloodTypeOptions
                            )
                            
                            Divider()
                            
                            FormPickerField(
                                label: "Blood Pressure",
                                selection: $viewModel.bloodPressure,
                                options: viewModel.bloodPressureOptions
                            )
                            
                            Divider()
                            
                            FormPickerField(
                                label: "Blood Sugar",
                                selection: $viewModel.bloodSugar,
                                options: viewModel.bloodSugarOptions
                            )
                        }
                    }
                    .padding(.horizontal, 25)
                    //.padding(.top, 20)
                    
                    // MARK: - Medical Records
                    ZStack(alignment: .topLeading) {
                        if viewModel.medicalRecords.isEmpty {
                            Text("Add allergies, conditions , or any other relevant medical records.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray.opacity(0.6))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                        }
                        
                        TextEditor(text: $viewModel.medicalRecords)
                            .font(.system(size: 14))
                            .frame(height: 100)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                            )
                    )
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 16)
                    
                    // MARK: - Add Patient Button
                    VStack(spacing: 16) {
                        Button(action: {
                            if let patient = viewModel.addPatient() {
                                newlyAddedPatient = patient
                                onPatientAdded?(patient)
                                navigateToBooking = true
                            }
                        }) {
                            Text("Add Patient")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color(hex: "0930A6"))
                                )
                        }
                        
                        // MARK: - Cancel Button
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color(hex: "0930A6"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color(hex: "0930A6"), lineWidth: 2)
                                        .background(
                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(Color.white)
                                        )
                                )
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 16)
                    .padding(.bottom, 60)
                }
            }
            
            // MARK: - Back Button
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
            
            // MARK: - Notification Button
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
        
        .navigationDestination(isPresented: $navigateToBooking) {
            BookAppointmentView(doctor: doctor)
        }
        
        .alert("Error", isPresented: $viewModel.showValidationError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.validationMessage)
        }
    }
}

#Preview {
    AddPatientView(doctor: Doctor.sampleDoctors[0])
        //.environmentObject(TabBarManager())
}
