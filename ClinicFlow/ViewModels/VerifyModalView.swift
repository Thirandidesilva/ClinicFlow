//
// VerifyModalView.swift
// ClinicFlow
//
// Created by Thirandi De Silva on 2026-02-20
//




import SwiftUI

struct VerifyModalView: View {
    @ObservedObject var viewModel: SetupViewModel
    var onVerificationComplete: () -> Void
    @FocusState private var focusedIndex: Int?
    
    var body: some View {
        ZStack {
            // Dimmed Background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        viewModel.showVerifyModal = false
                    }
                }
            
            // Modal Content
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Verify Your Email")
                            .font(.system(size: 24, weight: .semibold, design: .default))
                            .tracking(-0.3)
                            .foregroundColor(.black)
                        
                        Text("Enter the verification code we just sent to your email")
                            .font(.system(size: 15, weight: .regular, design: .default))
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 8)
                    
                    // OTP Input Fields
                    HStack(spacing: 14) {
                        ForEach(0..<5, id: \.self) { index in
                            OTPInputField(
                                text: $viewModel.verificationCodes[index],
                                isFocused: focusedIndex == index,
                                onFocus: { focusedIndex = index },
                                onBackspace: {
                                    if viewModel.verificationCodes[index].isEmpty && index > 0 {
                                        focusedIndex = index - 1
                                    }
                                },
                                onNextField: {
                                    if index < 4 {
                                        focusedIndex = index + 1
                                    }
                                }
                            )
                        }
                    }
                    .frame(height: 64)
                    
                    // Error Message
                    if !viewModel.verificationError.isEmpty {
                        Text(viewModel.verificationError)
                            .font(.system(size: 12, weight: .regular, design: .default))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    // Verify Button
                    Button(action: {
                        viewModel.verifyOTP(completion: onVerificationComplete)
                    }) {
                        if viewModel.isVerifying {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Verify")
                                .font(.system(size: 17, weight: .semibold, design: .default))
                        }
                    }
                    .disabled(viewModel.isVerifying)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.1, green: 0.3, blue: 0.85),
                                Color(red: 0.15, green: 0.35, blue: 0.95)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(25)
                    
                    // Resend Option
                    HStack(spacing: 4) {
                        Text("Didn't receive any code?")
                            .font(.system(size: 13, weight: .regular, design: .default))
                            .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        
                        Button(action: {
                            // Resend OTP logic
                            viewModel.resetForm()
                        }) {
                            Text("Resend")
                                .font(.system(size: 13, weight: .semibold, design: .default))
                                .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.85))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 4)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
                .background(Color.white)
                .cornerRadius(28, corners: [.topLeft, .topRight])
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

struct OTPInputField: View {
    @Binding var text: String
    let isFocused: Bool
    let onFocus: () -> Void
    let onBackspace: () -> Void
    let onNextField: () -> Void
    @State private var previousText: String = ""
    
    var body: some View {
        VStack {
            TextField("", text: $text)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .multilineTextAlignment(.center)
                .font(.system(size: 28, weight: .semibold, design: .default))
                .foregroundColor(.black)
                .onChange(of: text) { oldValue, newValue in
                    var filteredText = newValue
                    
                    // Check if user pressed backspace (text length decreased)
                    if newValue.count < oldValue.count && newValue.isEmpty {
                        onBackspace()
                        text = ""
                        return
                    }
                    
                    // Only allow single digit
                    if filteredText.count > 1 {
                        filteredText = String(filteredText.last ?? Character(""))
                    }
                    
                    // Only allow numbers
                    if !filteredText.allSatisfy({ $0.isNumber }) {
                        filteredText = oldValue
                    }
                    
                    text = filteredText
                    
                    // Auto move to next field
                    if filteredText.count == 1 {
                        onNextField()
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 64)
        .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(
                    isFocused ? Color(red: 0.2, green: 0.4, blue: 1.0) : Color(red: 0.9, green: 0.9, blue: 0.95),
                    lineWidth: isFocused ? 2 : 1
                )
        )
    }
}

// MARK: - Custom RoundedCorner Modifier
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

#Preview {
    ZStack {
        // Background behind modal
        Color(red: 0.98, green: 0.98, blue: 0.99)
            .ignoresSafeArea()
        
        // Show the modal
        VerifyModalView(viewModel: SetupViewModel()) {
            print("Verification complete")
        }
    }
}
