//
//  Speciality.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import Foundation

struct Specialty: Identifiable, Hashable {
    let id: String
    let name: String
    let imageName: String
    let backgroundColor: String  // Hex color
}

// Sample data
extension Specialty {
    static let allSpecialties = [
        Specialty(id: "1", name: "General", imageName: "stethoscope", backgroundColor: "C8E6F5"),
        Specialty(id: "2", name: "Cardiology", imageName: "heart", backgroundColor: "FFD4D4"),
        Specialty(id: "3", name: "Dentistry", imageName: "tooth", backgroundColor: "E3EFFF"),
        Specialty(id: "4", name: "Pulmonology", imageName: "lungs", backgroundColor: "FFFFFF"),
        Specialty(id: "5", name: "Neorology", imageName: "brain", backgroundColor: "FFD9E5"),
        Specialty(id: "6", name: "Gastroenterology", imageName: "intestine", backgroundColor: "FFD4D4"),
        Specialty(id: "7", name: "Orthopaedic", imageName: "bone", backgroundColor: "FFE8DB"),
        Specialty(id: "8", name: "Otolaryngology", imageName: "ear", backgroundColor: "FFFFFF")
    ]
}
