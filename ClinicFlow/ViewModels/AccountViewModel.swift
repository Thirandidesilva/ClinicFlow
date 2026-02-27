//
//  AccountViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI
import Combine

class AccountViewModel: ObservableObject {
    @Published var firstName: String = "Kaveen"
    @Published var lastName: String = "De Silva"
    @Published var phoneNumber: String = "077 3834 565"
    @Published var email: String = "kaveen@gmail.com"

    var fullName: String {
        "\(firstName) \(lastName)"
    }

    func updateName(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    func updatePhone(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

    func updateEmail(email: String) {
        self.email = email
    }

    func logOut() {
        // Handle log out logic here
        print("User logged out")
    }
}
