//
//  EditRecordView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI

struct EditRecordView: View {
    @ObservedObject var viewModel: EditRecordViewModel
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
                    Text("Edit Records")
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
                VStack(spacing: 20) {

                    // MARK: Patient Card
                    HStack(spacing: 14) {
                        Circle()
                            .fill(Color(hex: "1A1AE6"))
                            .frame(width: 46, height: 46)
                            .overlay(
                                Text(String(viewModel.fullName.prefix(1)))
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            )
                        VStack(alignment: .leading, spacing: 3) {
                            Text(viewModel.fullName)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Last Updated: Feb 20, 2026")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.85))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(hex: "1A1AE6"))
                    )
                    .padding(.horizontal, 16)

                    // MARK: Personal Details
                    EditSectionCard(title: "Personal Details") {
                        EditFieldRow(label: "Full Name", value: $viewModel.fullName)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Age", value: $viewModel.age)
                            .keyboardType(.numberPad)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Gender", value: $viewModel.gender)
                    }
                    .padding(.horizontal, 16)

                    // MARK: Vitals
                    EditSectionCard(title: "Vitals") {
                        EditFieldRow(label: "Heart Rate", value: $viewModel.heartRate)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Blood Pressure", value: $viewModel.bloodPressure)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Weight", value: $viewModel.weight)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Blood Sugar", value: $viewModel.bloodSugar)
                    }
                    .padding(.horizontal, 16)

                    // MARK: Medical Information
                    EditSectionCard(title: "Medical Informations") {
                        EditFieldRow(label: "Blood Type", value: $viewModel.bloodType)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Allergies", value: $viewModel.allergies)
                        Divider().padding(.leading, 16)
                        EditFieldRow(label: "Vaccinations", value: $viewModel.vaccinations)
                    }
                    .padding(.horizontal, 16)

                    // MARK: Current Medication
                    EditSectionCard(title: "Current Medication") {
                        ForEach($viewModel.medications) { $med in
                            EditFieldRow(label: med.name, value: $med.status)
                            if med.id != viewModel.medications.last?.id {
                                Divider().padding(.leading, 16)
                            }
                        }
                    }
                    .padding(.horizontal, 16)

                    // MARK: Save Button
                    Button(action: {
                        viewModel.save()
                        dismiss()
                    }) {
                        Text("Save")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(hex: "1A1AE6"))
                            .cornerRadius(30)
                    }
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

// MARK: - Edit Section Card
struct EditSectionCard<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 10)

            VStack(spacing: 0) {
                content
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}

// MARK: - Edit Field Row
struct EditFieldRow: View {
    let label: String
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(.primary)
                .frame(width: 130, alignment: .leading)
            Spacer()
            TextField(label, text: $value)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
                .keyboardType(keyboardType)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    EditRecordView(viewModel: EditRecordViewModel(healthRecordViewModel: HealthRecordViewModel()))
}
