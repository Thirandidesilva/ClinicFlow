//
//  DoctorInfoHeader.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct DoctorInfoHeader: View {
    let doctor: Doctor
    
    var body: some View {
        HStack(spacing: 16) {
            // Doctor Image
            Image(doctor.image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // Doctor Info
            VStack(alignment: .leading, spacing: 6) {
                Text(doctor.name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Text(doctor.speciality)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Image(systemName: "location.circle")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Text(doctor.clinic)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    DoctorInfoHeader(doctor: Doctor.sampleDoctors[0])
        .padding()
}
