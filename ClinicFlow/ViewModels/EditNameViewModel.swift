//
//  EditNameViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI
import Combine

class EditNameViewModel: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    @Published var navigateToProfile: Bool = false

    private var accountViewModel: AccountViewModel

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
        self.firstName = accountViewModel.firstName
        self.lastName = accountViewModel.lastName
    }

    var isFormValid: Bool {
        !firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !lastName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func updateName() {
        guard isFormValid else { return }
        accountViewModel.updateName(firstName: firstName, lastName: lastName)
        navigateToProfile = true
    }
}
