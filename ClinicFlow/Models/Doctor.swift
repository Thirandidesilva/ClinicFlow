//
//  Doctor.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-25.
//

import Foundation

struct Doctor: Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let speciality: String
    let clinic: String
    let patientsCount: Int
    let experienceYears: Int
    let ratingsCount: Int
    let reviewsCount: Int
    let rating: Double
    let price: Int
    let about: String
    let workingTime: String
    
    // Optional helper for UI display
    var formattedPrice: String {
        "LKR \(price.formatted())"
    }
}

// MARK: - Sample Data

extension Doctor {
    static let sampleDoctors: [Doctor] = [
        
        Doctor(
            id: "1",
            name: "Elizabeth Blackwell",
            image: "dr.elizabeth",
            speciality: "Cardiologist",
            clinic: "Golden Medical Clinic",
            patientsCount: 3000,
            experienceYears: 10,
            ratingsCount: 5,
            reviewsCount: 1620,
            rating: 5.0,
            price: 3000,
            about: "Dr. Elizabeth Blackwell, a dedicated cardiologist, bringing a wealth of experience to Golden Medical Clinic in Sri Lanka.",
            workingTime: "Mon | Tue | Wed"
        ),
        
        Doctor(
            id: "2",
            name: "David Patel",
            image: "dr2",
            speciality: "Neurologist",
            clinic: "Central Hospital",
            patientsCount: 2500,
            experienceYears: 12,
            ratingsCount: 5,
            reviewsCount: 1450,
            rating: 4.9,
            price: 3500,
            about: "Dr. David Patel is a renowned neurologist specializing in brain disorders and neurological conditions with over a decade of experience.",
            workingTime: "Mon | Tue | Thu"
        ),
        
        Doctor(
            id: "3",
            name: "Edward Jenner",
            image: "dr3",
            speciality: "General Physician",
            clinic: "City Medical Center",
            patientsCount: 4200,
            experienceYears: 15,
            ratingsCount: 5,
            reviewsCount: 2100,
            rating: 4.8,
            price: 2500,
            about: "Dr. Edward Jenner is an experienced general physician providing comprehensive healthcare services for patients of all ages.",
            workingTime: "Wed | Thu | Fri"
        ),
        
        Doctor(
            id: "4",
            name: "Sarah Johnson",
            image: "dr.sarah",
            speciality: "Pediatrician",
            clinic: "Children's Healthcare",
            patientsCount: 3500,
            experienceYears: 9,
            ratingsCount: 5,
            reviewsCount: 1890,
            rating: 5.0,
            price: 2800,
            about: "Dr. Sarah Johnson is a caring pediatrician dedicated to providing the best healthcare for children and adolescents.",
            workingTime: "Mon | Tue | Thu"
        ),
        
        Doctor(
            id: "5",
            name: "Michael Chen",
            image: "dr.michael",
            speciality: "Orthopedic Surgeon",
            clinic: "Bone & Joint Clinic",
            patientsCount: 2800,
            experienceYears: 11,
            ratingsCount: 5,
            reviewsCount: 1320,
            rating: 4.7,
            price: 4000,
            about: "Dr. Michael Chen is a skilled orthopedic surgeon specializing in joint replacements and sports injuries.",
            workingTime: "Mon | Tue | Sat"
        ),
        
        Doctor(
            id: "6",
            name: "Jonathan Smith",
            image: "dr.jonathan",
            speciality: "Pediatrician",
            clinic: "Children's Healthcare",
            patientsCount: 2800,
            experienceYears: 11,
            ratingsCount: 5,
            reviewsCount: 1320,
            rating: 4.7,
            price: 2700,
            about: "Dr. Jonathan Smith is a skilled pediatrician specializing in children's health and well-being.",
            workingTime: "Mon | Tue | Thu"
        )
    ]
}
