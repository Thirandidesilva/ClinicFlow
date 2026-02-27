//
//  EditPhoneViewModel.swift
//  ClinicFlow
//
//  Created by Thirandi De Silva on 2026-02-27
//

import SwiftUI
import Combine

class EditPhoneViewModel: ObservableObject {
    @Published var phoneNumber: String
    @Published var navigateToProfile: Bool = false

    private var accountViewModel: AccountViewModel

    init(accountViewModel: AccountViewModel) {
        self.accountViewModel = accountViewModel
        self.phoneNumber = accountViewModel.phoneNumber
    }

    var isFormValid: Bool {
        !phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func updatePhone() {
        guard isFormValid else { return }
        accountViewModel.updatePhone(phoneNumber: phoneNumber)
        navigateToProfile = true
    }
}
