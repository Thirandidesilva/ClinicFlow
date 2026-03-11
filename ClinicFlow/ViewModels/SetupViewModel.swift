//
//  SetupViewModel.swift
//  Clinic Flow
//
//  Created by Thirandi De Silva on 2026-02-24

import Foundation
import SwiftUI
import Combine

class SetupViewModel: ObservableObject {
    @Published var emailInput: String = ""
    @Published var showVerifyModal: Bool = false
    @Published var otpCode: String = ""
    @Published var verificationCodes: [String] = ["", "", "", "", ""]
    @Published var isVerifying: Bool = false
    @Published var verificationError: String = ""
    
    // MARK: - Email Validation
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email) && !email.isEmpty
    }
    
    // MARK: - Send OTP
    func sendOTP() {
        guard validateEmail(emailInput) else {
            verificationError = "Please enter a valid email"
            return
        }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            showVerifyModal = true
        }
        
        // Simulate OTP generation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // In real app, this would come from backend
            self.otpCode = "1234"
        }
    }
    
    // MARK: - Verify OTP
    func verifyOTP(completion: @escaping () -> Void) {
        let enteredCode = verificationCodes.joined()
        
        guard enteredCode.count == 5 else {
            verificationError = "Please enter all 5 digits"
            return
        }
        
        isVerifying = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isVerifying = false
            
            // For frontend demo, accept any code
            if enteredCode.count == 5 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.showVerifyModal = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    completion()
                }
            } else {
                self.verificationError = "Invalid OTP code"
            }
        }
    }
    
    // MARK: - Social Sign In
    func signInWithGoogle(completion: @escaping () -> Void) {
        // Simulate Google sign-in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion()
        }
    }
    
    func signInWithApple(completion: @escaping () -> Void) {
        // Simulate Apple sign-in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion()
        }
    }
    
    // MARK: - Reset Form
    func resetForm() {
        emailInput = ""
        verificationCodes = ["", "", "", "", ""]
        verificationError = ""
    }
}
