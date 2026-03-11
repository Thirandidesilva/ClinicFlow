//
//  FormSectionCard.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct FormSectionCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
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
    FormSectionCard {
        VStack(alignment: .leading, spacing: 0) {
            FormInputField(label: "Full Name", placeholder: "Enter Patient Name", text: .constant(""))
            
            Divider()
            
            FormInputField(label: "Age", placeholder: "Enter Age", text: .constant(""))
        }
    }
    .padding()
}
