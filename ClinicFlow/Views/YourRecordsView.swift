//
//  YourRecordsView.swift
//  ClinicFlow
//
//  Created by M H T U De Silva
//

import SwiftUI

struct YourRecordsView: View {
    @ObservedObject var viewModel: HealthRecordViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {

                // MARK: Patient Card
                HStack(spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 46, height: 46)
                        Text(viewModel.myRecord.initials)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.myRecord.avatarColor)
                    }

                    VStack(alignment: .leading, spacing: 3) {
                        Text(viewModel.myRecord.name)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("Last Updated: \(viewModel.myRecord.lastUpdated)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.85))
                    }

                    Spacer()

                    // Edit button navigates to EditRecordView
                    NavigationLink(destination: EditRecordView(
                        viewModel: EditRecordViewModel(healthRecordViewModel: viewModel)
                    )) {
                        Circle()
                            .fill(Color.white.opacity(0.2))
                            .frame(width: 36, height: 36)
                            .overlay(
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .semibold))
                            )
                            .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 1))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(hex: "1A1AE6"))
                )
                .padding(.horizontal, 16)

                // MARK: Vitals Section
                VitalsSection(vitals: viewModel.myRecord.vitals)
                    .padding(.horizontal, 16)

                // MARK: Medical Information
                MedicalInfoSection(medicalInfo: viewModel.myRecord.medicalInfo)
                    .padding(.horizontal, 16)

                // MARK: Current Medication
                MedicationSection(medications: viewModel.myRecord.medications)
                    .padding(.horizontal, 16)

                // Bottom spacing for nav bar
                Color.clear.frame(height: 90)
            }
            .padding(.top, 8)
        }
        .background(Color(hex: "F5F5F5"))
    }
}

// MARK: - Vitals Section
struct VitalsSection: View {
    let vitals: Vital

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Vitals")
                .font(.headline)
                .fontWeight(.semibold)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                VitalCard(icon: "icn_heart", iconColor: Color(hex: "E74C3C"), title: "Heart Rate", value: vitals.heartRate, unit: "bpm")
                VitalCard(icon: "icn_blood", iconColor: Color(hex: "E74C3C"), title: "Blood Pressure", value: vitals.bloodPressure, unit: "mmHg")
                VitalCard(icon: "icn_weight", iconColor: Color(hex: "3498DB"), title: "Weight", value: vitals.weight, unit: "kg")
                VitalCard(icon: "icn_sugar", iconColor: Color(hex: "2ECC71"), title: "Blood Sugar", value: vitals.bloodSugar, unit: "mg/dL")
            }
        }
    }
}

// MARK: - Vital Card
struct VitalCard: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                Image(icon)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(iconColor)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Medical Info Section
struct MedicalInfoSection: View {
    let medicalInfo: MedicalInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Medical Information")
                .font(.headline)
                .fontWeight(.semibold)

            VStack(spacing: 0) {
                MedicalInfoRow(label: "Blood Type", value: medicalInfo.bloodType, valueColor: .primary)
                Divider().padding(.leading, 16)
                MedicalInfoRow(label: "Allergies", value: medicalInfo.allergies, valueColor: Color(hex: "E74C3C"))
                Divider().padding(.leading, 16)
                MedicalInfoRow(label: "Vaccinations", value: medicalInfo.vaccinations, valueColor: Color(hex: "2ECC71"))
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}

struct MedicalInfoRow: View {
    let label: String
    let value: String
    let valueColor: Color

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(valueColor)
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color(hex: "AAAAAA"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

// MARK: - Medication Section
struct MedicationSection: View {
    let medications: [Medication]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Current Medication")
                .font(.headline)
                .fontWeight(.semibold)

            VStack(spacing: 0) {
                ForEach(medications) { med in
                    HStack {
                        Text(med.name)
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                        Text(med.status)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: "2ECC71"))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 5)
                            .background(Color(hex: "2ECC71").opacity(0.12))
                            .cornerRadius(20)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(hex: "AAAAAA"))
                            .padding(.leading, 6)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    if med.id != medications.last?.id {
                        Divider().padding(.leading, 16)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}
