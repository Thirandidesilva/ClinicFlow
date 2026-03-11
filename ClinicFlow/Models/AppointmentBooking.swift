//
//  AppointmentBooking.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-04.
//


import Foundation

struct AppointmentBooking: Codable {
    let appointmentNumber: String
    let doctor: Doctor
    let patient: Patient
    let date: Date
    let time: String
    let estimatedTime: String
    let doctorArrivalTime: String
    let roomNumber: String
}
