//
//  FormPickerField.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-03-01.
//

import SwiftUI

struct FormPickerField: View {
    let label: String
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 120, alignment: .leading)
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selection = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selection)
                        .font(.system(size: 15))
                        .foregroundColor(isPlaceholder ? .gray : .black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 12)
    }
    
    private var isPlaceholder: Bool {
        selection == "Male" ||
        selection == "Weight" ||
        selection == "Blood Group" ||
        selection == "Blood Pressure" ||
        selection == "Blood Sugar"
    }
}
