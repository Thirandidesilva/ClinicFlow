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
        
        // MARK: - Cardiology (3 doctors)
        Doctor(
            id: "1",
            name: "Elizabeth Blackwell",
            image: "dr.elizabeth",
            speciality: "Cardiology",
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
            speciality: "Cardiology",
            clinic: "Central Hospital",
            patientsCount: 2500,
            experienceYears: 12,
            ratingsCount: 5,
            reviewsCount: 1450,
            rating: 4.9,
            price: 2500,
            about: "Dr. David Patel is a renowned cardiologist specializing in heart conditions with over a decade of experience.",
            workingTime: "Mon | Tue | Wed"
        ),
        
        Doctor(
            id: "3",
            name: "Edward Jenner",
            image: "dr3",
            speciality: "Cardiology",
            clinic: "City Medical Center",
            patientsCount: 4200,
            experienceYears: 15,
            ratingsCount: 5,
            reviewsCount: 2100,
            rating: 4.8,
            price: 2000,
            about: "Dr. Edward Jenner is an experienced cardiologist providing comprehensive cardiovascular care.",
            workingTime: "Thu | Fri"
        ),
        
        // MARK: - Dentistry (3 doctors)
        Doctor(
            id: "4",
            name: "Sarah Johnson",
            image: "dr.sarah",
            speciality: "Dentistry",
            clinic: "Smile Dental Care",
            patientsCount: 3500,
            experienceYears: 9,
            ratingsCount: 5,
            reviewsCount: 1890,
            rating: 5.0,
            price: 2800,
            about: "Dr. Sarah Johnson is a caring dentist dedicated to providing comprehensive dental care.",
            workingTime: "Mon | Tue | Thu"
        ),
        
        Doctor(
            id: "5",
            name: "Amanda Rodriguez",
            image: "dr.amanda",
            speciality: "Dentistry",
            clinic: "Perfect Smile Clinic",
            patientsCount: 3200,
            experienceYears: 8,
            ratingsCount: 5,
            reviewsCount: 1560,
            rating: 4.9,
            price: 2500,
            about: "Dr. Amanda Rodriguez is an expert in cosmetic and restorative dentistry.",
            workingTime: "Mon | Wed | Fri"
        ),
        
        Doctor(
            id: "6",
            name: "James Wilson",
            image: "dr.james",
            speciality: "Dentistry",
            clinic: "Dental Excellence",
            patientsCount: 2900,
            experienceYears: 11,
            ratingsCount: 5,
            reviewsCount: 1420,
            rating: 4.7,
            price: 3000,
            about: "Dr. James Wilson specializes in dental implants and oral surgery.",
            workingTime: "Tue | Thu | Sat"
        ),
        
        // MARK: - Pulmonology (2 doctors)
        Doctor(
            id: "7",
            name: "Jonathan Smith",
            image: "dr.jonathan",
            speciality: "Pulmonology",
            clinic: "Respiratory Health Center",
            patientsCount: 2800,
            experienceYears: 11,
            ratingsCount: 5,
            reviewsCount: 1320,
            rating: 4.7,
            price: 2700,
            about: "Dr. Jonathan Smith specializes in respiratory care and lung diseases.",
            workingTime: "Mon | Tue | Thu"
        ),
        
        Doctor(
            id: "8",
            name: "Robert Kim",
            image: "dr.robert",
            speciality: "Pulmonology",
            clinic: "Lung Care Institute",
            patientsCount: 2600,
            experienceYears: 13,
            ratingsCount: 5,
            reviewsCount: 1480,
            rating: 4.8,
            price: 3200,
            about: "Dr. Robert Kim specializes in asthma, COPD, and respiratory infections.",
            workingTime: "Tue | Thu | Sat"
        ),
        
        // MARK: - Neorology (3 doctors)
        Doctor(
            id: "9",
            name: "Lisa Chen",
            image: "dr.lisa",
            speciality: "Neorology",
            clinic: "Brain Health Center",
            patientsCount: 3100,
            experienceYears: 10,
            ratingsCount: 5,
            reviewsCount: 1650,
            rating: 4.9,
            price: 3500,
            about: "Dr. Lisa Chen is an expert neurologist specializing in brain disorders and neurological conditions.",
            workingTime: "Mon | Wed | Fri"
        ),
        
        Doctor(
            id: "10",
            name: "Mark Anderson",
            image: "dr.mark",
            speciality: "Neorology",
            clinic: "Neuro Wellness Clinic",
            patientsCount: 2700,
            experienceYears: 14,
            ratingsCount: 5,
            reviewsCount: 1520,
            rating: 4.8,
            price: 3800,
            about: "Dr. Mark Anderson specializes in stroke care and movement disorders.",
            workingTime: "Tue | Thu | Fri"
        ),
        
        Doctor(
            id: "11",
            name: "Emily White",
            image: "dr.emily",
            speciality: "Neorology",
            clinic: "Advanced Neurology Center",
            patientsCount: 2900,
            experienceYears: 9,
            ratingsCount: 5,
            reviewsCount: 1390,
            rating: 4.7,
            price: 3300,
            about: "Dr. Emily White focuses on epilepsy and headache disorders.",
            workingTime: "Mon | Tue | Wed"
        ),
        
        // MARK: - Gastroenterology (2 doctors)
        Doctor(
            id: "12",
            name: "Daniel Brown",
            image: "dr.daniel",
            speciality: "Gastroenterology",
            clinic: "Digestive Health Center",
            patientsCount: 2600,
            experienceYears: 13,
            ratingsCount: 5,
            reviewsCount: 1480,
            rating: 4.8,
            price: 3200,
            about: "Dr. Daniel Brown specializes in digestive system disorders and liver diseases.",
            workingTime: "Tue | Thu | Sat"
        ),
        
        Doctor(
            id: "13",
            name: "Patricia Martinez",
            image: "dr.patricia",
            speciality: "Gastroenterology",
            clinic: "GI Wellness Institute",
            patientsCount: 2400,
            experienceYears: 10,
            ratingsCount: 5,
            reviewsCount: 1350,
            rating: 4.9,
            price: 2900,
            about: "Dr. Patricia Martinez focuses on inflammatory bowel disease and colonoscopy.",
            workingTime: "Mon | Wed | Thu"
        ),
        
        // MARK: - Orthopaedic (3 doctors)
        Doctor(
            id: "14",
            name: "Michael Chen",
            image: "dr.michael",
            speciality: "Orthopaedic",
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
            id: "15",
            name: "Kevin Taylor",
            image: "dr.kevin",
            speciality: "Orthopaedic",
            clinic: "Sports Ortho Center",
            patientsCount: 3000,
            experienceYears: 12,
            ratingsCount: 5,
            reviewsCount: 1550,
            rating: 4.8,
            price: 4200,
            about: "Dr. Kevin Taylor specializes in sports medicine and arthroscopic surgery.",
            workingTime: "Tue | Wed | Fri"
        ),
        
        Doctor(
            id: "16",
            name: "Rachel Green",
            image: "dr.rachel",
            speciality: "Orthopaedic",
            clinic: "Spine & Joint Institute",
            patientsCount: 2650,
            experienceYears: 9,
            ratingsCount: 5,
            reviewsCount: 1280,
            rating: 4.9,
            price: 3900,
            about: "Dr. Rachel Green focuses on spine surgery and trauma care.",
            workingTime: "Mon | Thu | Fri"
        ),
        
        // MARK: - Otolaryngology (2 doctors)
        Doctor(
            id: "17",
            name: "Steven Harris",
            image: "dr.steven",
            speciality: "Otolaryngology",
            clinic: "ENT Specialists",
            patientsCount: 2500,
            experienceYears: 10,
            ratingsCount: 5,
            reviewsCount: 1400,
            rating: 4.8,
            price: 3100,
            about: "Dr. Steven Harris specializes in ear, nose, and throat disorders.",
            workingTime: "Mon | Tue | Thu"
        ),
        
        Doctor(
            id: "18",
            name: "Olivia Thompson",
            image: "dr.olivia",
            speciality: "Otolaryngology",
            clinic: "Head & Neck Care Center",
            patientsCount: 2300,
            experienceYears: 8,
            ratingsCount: 5,
            reviewsCount: 1250,
            rating: 4.7,
            price: 2800,
            about: "Dr. Olivia Thompson focuses on sinus surgery and hearing disorders.",
            workingTime: "Wed | Thu | Fri"
        )
    ]
}
