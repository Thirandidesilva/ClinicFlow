//
//  PatientDropdownField.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-02.
//

import SwiftUI

struct PatientDropdownField: View {
    @State private var showAddPatient = false
    @Binding var selectedPatient: Patient?
    let patients: [Patient]
    let onAddNewPatient: () -> Void
    
    var body: some View {
        Menu {
            Button(action: onAddNewPatient) {
                Label("New Patient", systemImage: "plus.circle")
            }
            
            Divider()
            
            ForEach(patients) { patient in
                Button(action: {
                    selectedPatient = patient
                }) {
                    Text(patient.name)
                }
            }
        } label: {
            HStack(spacing: 12) {
                Image("vector")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "0930A6"))
                
                Text(selectedPatient?.name ?? "Patient Name")
                    .font(.system(size: 15))
                    .foregroundColor(selectedPatient == nil ? .gray : .black)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "0930A6").opacity(0.5))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(hex: "0930A6").opacity(0.4), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
            )
        }
    }
}

#Preview {
    PatientDropdownField(
        selectedPatient: .constant(nil),
        patients: Patient.samplePatients,
        onAddNewPatient: {
            print("Add new patient")
        }
    )
    .padding()
}
