//
//  RiviewCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct ReviewCard: View {
    let review: Review
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Reviewer Image
            Image(review.reviewerImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            // Review Content
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(review.reviewerName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Rating
                    HStack(spacing: 4) {
                        Text(String(format: "%.1f", review.rating))
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        ForEach(0..<5) { index in
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(index < Int(review.rating) ? .yellow : .gray.opacity(0.3))
                        }
                    }
                }
                
                Text(review.comment)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
    }
}

#Preview {
    ReviewCard(review: Review.sampleReviews[0])
        .padding()
}
