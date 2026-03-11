//
//  Patient.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-02.
//

import Foundation

struct Patient: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let age: String
    let gender: String
    let contactNumber: String
    let address: String
    
    init(id: String = UUID().uuidString, name: String, age: String = "", gender: String = "Male", contactNumber: String = "", address: String = "") {
        self.id = id
        self.name = name
        self.age = age
        self.gender = gender
        self.contactNumber = contactNumber
        self.address = address
    }
}

extension Patient {
    static let samplePatients = [
        Patient(id: "1", name: "Kaveen De Silva", age: "25", gender: "Male", contactNumber: "077 348 9284", address: "Colombo 05"),
        Patient(id: "2", name: "Sunethri Ranaweera", age: "30", gender: "Female", contactNumber: "077 123 4567", address: "Colombo 07"),
        Patient(id: "3", name: "Suni De Silva", age: "28", gender: "Male", contactNumber: "077 987 6543", address: "Colombo 03")
    ]
}
