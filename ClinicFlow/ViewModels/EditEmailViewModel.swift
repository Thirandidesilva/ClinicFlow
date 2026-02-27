//
//  EditEmailViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI
import Combine

class EditEmailViewModel: ObservableObject {
    @Published var email: String
    @Published var navigateToProfile: Bool = false

    private var accountViewModel: AccountViewModel

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
        self.email = accountViewModel.email
    }

    var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty &&
        email.contains("@")
    }

    func updateEmail() {
        guard isFormValid else { return }
        accountViewModel.updateEmail(email: email)
        navigateToProfile = true
    }
}
