//
//  RequestInfoCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct RequestInfoCard: View {
    let reasonTitle: String
    let reasonDescription: String
    let departmentTitle: String
    let departmentName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Title
            Text("Request Info")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.black)
            
            // Reason for Emergency
            HStack(alignment: .top, spacing: 16) {
                // Icon circle
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 48, height: 4)
                    
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 4) {
                    Text(reasonTitle)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                        .textCase(.uppercase)
                    
                    Text(reasonDescription)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
            // Divider
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 1)
            
            // Department/Ward
            HStack(alignment: .top, spacing: 16) {
                // Icon circle
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 48, height: 4)
                    
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                }
                
                // Text content
                VStack(alignment: .leading, spacing: 4) {
                    Text(departmentTitle)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.gray)
                        .textCase(.uppercase)
                    
                    Text(departmentName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                )
        )
    }
}

#Preview {
    RequestInfoCard(
        reasonTitle: "REASON FOR EMERGENCY",
        reasonDescription: "Suspected acute infection - rapid CBC required",
        departmentTitle: "DEPARTMENT/WARD",
        departmentName: "Internal Medicine — Ward 3B"
    )
    .padding()
    .background(Color.gray.opacity(0.1))
}
