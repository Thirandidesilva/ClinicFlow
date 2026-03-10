//
//  OtherRecordsView.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-28
//

import SwiftUI

struct OtherRecordsView: View {
    @ObservedObject var viewModel: HealthRecordViewModel
    @State private var searchText: String = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {

                // MARK: Search Bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex: "AAAAAA"))
                    TextField("Search Patient Name", text: $searchText)
                        .font(.body)
                    Spacer()
                    Image(systemName: "mic.fill")
                        .foregroundColor(Color(hex: "AAAAAA"))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color(hex: "EEEEEE"), lineWidth: 1)
                )
                .padding(.horizontal, 16)

                // MARK: Family Members
                VStack(alignment: .leading, spacing: 10) {
                    Text("Family Members")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        ForEach(filteredFamily) { patient in
                            NavigationLink(value: NavigationRoute.otherPatientRecord(patient)) {
                                PatientListRow(patient: patient)
                            }
                            if patient.id != filteredFamily.last?.id {
                                Divider().padding(.leading, 72)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                }

                // MARK: Other Patients
                VStack(alignment: .leading, spacing: 10) {
                    Text("Other Patients")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        ForEach(filteredOthers) { patient in
                            NavigationLink(value: NavigationRoute.otherPatientRecord(patient)) {
                                PatientListRow(patient: patient)
                            }
                            if patient.id != filteredOthers.last?.id {
                                Divider().padding(.leading, 72)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                }

                Color.clear.frame(height: 90)
            }
            .padding(.top, 8)
        }
        .background(Color(hex: "F5F5F5"))
    }

    // MARK: - Filtered Lists
    var filteredFamily: [OtherPatient] {
        searchText.isEmpty ? viewModel.familyMembers :
        viewModel.familyMembers.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var filteredOthers: [OtherPatient] {
        searchText.isEmpty ? viewModel.otherPatients :
        viewModel.otherPatients.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}

// MARK: - Patient List Row
struct PatientListRow: View {
    let patient: OtherPatient

    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(patient.avatarColor)
                .frame(width: 44, height: 44)
                .overlay(
                    Text(patient.initials)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )

            VStack(alignment: .leading, spacing: 3) {
                Text(patient.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(patient.age)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Color(hex: "AAAAAA"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}
