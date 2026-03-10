//
//  FormInputField.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct FormInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 120, alignment: .leading)
            
            TextField(placeholder, text: $text)
                .font(.system(size: 15))
                .foregroundColor(.black)
                .keyboardType(keyboardType)
        }
        .padding(.vertical, 12)
    }
}

#Preview {
    VStack {
        FormInputField(label: "Full Name", placeholder: "Enter Patient Name", text: .constant(""))
        FormInputField(label: "Age", placeholder: "Enter Age", text: .constant(""))
    }
    .padding()
}
