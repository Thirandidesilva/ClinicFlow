//
//  NavigationRoute.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-10.
//

import SwiftUI

enum NavigationRoute: Hashable {
    case consultation
    case appointmentDashboard
    case healthRecords
    case otherPatientRecord(OtherPatient)
    case pharmacy
    case lab
    case emergencyLab
    case specialtyTab(Specialty?)
    case doctorDetail(Doctor)
    case bookAppointment(Doctor)
    case addPatient(Doctor)
    case appointmentDetail(AppointmentBooking)
    
    // Implement Hashable conformance
    static func == (lhs: NavigationRoute, rhs: NavigationRoute) -> Bool {
        switch (lhs, rhs) {
        case (.consultation, .consultation),
             (.appointmentDashboard, .appointmentDashboard),
             (.healthRecords, .healthRecords),
             (.pharmacy, .pharmacy),
             (.lab, .lab),
             (.emergencyLab, .emergencyLab):
            return true
        case (.specialtyTab(let lhsSpecialty), .specialtyTab(let rhsSpecialty)):
            return lhsSpecialty?.id == rhsSpecialty?.id
        case (.doctorDetail(let lhsDoctor), .doctorDetail(let rhsDoctor)):
            return lhsDoctor.id == rhsDoctor.id
        case (.bookAppointment(let lhsDoctor), .bookAppointment(let rhsDoctor)):
            return lhsDoctor.id == rhsDoctor.id
        case (.addPatient(let lhsDoctor), .addPatient(let rhsDoctor)):
            return lhsDoctor.id == rhsDoctor.id
        case (.otherPatientRecord(let lhs), .otherPatientRecord(let rhs)):
            return lhs.id == rhs.id
        case (.appointmentDetail(let lhsBooking), .appointmentDetail(let rhsBooking)):
            return lhsBooking.appointmentNumber == rhsBooking.appointmentNumber
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .consultation:
            hasher.combine("consultation")
        case .appointmentDashboard:
            hasher.combine("appointmentDashboard")
        case .healthRecords:
            hasher.combine("healthRecords")
        case .otherPatientRecord(let patient):
            hasher.combine("otherPatientRecord")
            hasher.combine(patient.id)
        case .pharmacy:
            hasher.combine("pharmacy")
        case .lab:
            hasher.combine("lab")
        case .emergencyLab:
            hasher.combine("emergencyLab")
        case .specialtyTab(let specialty):
            hasher.combine("specialtyTab")
            hasher.combine(specialty?.id)
        case .doctorDetail(let doctor):
            hasher.combine("doctorDetail")
            hasher.combine(doctor.id)
        case .bookAppointment(let doctor):
            hasher.combine("bookAppointment")
            hasher.combine(doctor.id)
        case .addPatient(let doctor):
            hasher.combine("addPatient")
            hasher.combine(doctor.id)
        case .appointmentDetail(let booking):
            hasher.combine("appointmentDetail")
            hasher.combine(booking.appointmentNumber)
        }
    }
}
