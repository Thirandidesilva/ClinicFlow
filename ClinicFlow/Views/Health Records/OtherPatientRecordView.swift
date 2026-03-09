//
//  OtherPatientRecordView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-28
//

import SwiftUI

struct OtherPatientRecordView: View {
    let patient: OtherPatient
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Fixed Header
            ZStack {
                Color(hex: "F5F5F5")
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    Text("Health Records")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 8)
                    Spacer()
                }
                .padding(.horizontal, 24)

                HStack {
                    Spacer()
                    NotificationButton()
                        .padding(.trailing, 16)
                }
            }
            .frame(height: 60)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {

                    // MARK: Patient Card
                    HStack(spacing: 14) {

                        // FIX 1: White circle with coloured initial inside
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 46, height: 46)
                            Text(patient.initials)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(patient.avatarColor)
                        }

                        VStack(alignment: .leading, spacing: 3) {
                            Text(patient.record.name)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Last Updated: \(patient.record.lastUpdated)")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.85))
                        }
                        Spacer()

                        // FIX 2: Pencil / edit icon added
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(patient.avatarColor)
                    )
                    .padding(.horizontal, 16)

                    // MARK: Vitals
                    VitalsSection(vitals: patient.record.vitals)
                        .padding(.horizontal, 16)

                    // MARK: Medical Information
                    MedicalInfoSection(medicalInfo: patient.record.medicalInfo)
                        .padding(.horizontal, 16)

                    // MARK: Current Medication
                    MedicationSection(medications: patient.record.medications)
                        .padding(.horizontal, 16)

                    Color.clear.frame(height: 90)
                }
                .padding(.top, 8)
            }
            .background(Color(hex: "F5F5F5"))
        }
        .background(Color(hex: "F5F5F5").ignoresSafeArea())
        .navigationBarHidden(true)
    }
}
