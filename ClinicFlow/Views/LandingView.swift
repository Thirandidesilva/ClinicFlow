//
// LandingView.swift
// ClinicFlow
//
// Created by Thirandi De Silva on 2026-02-20
//



import SwiftUI

struct LandingView: View {
    
    @StateObject private var viewModel = Landingviewmodel()
    
    private let backgroundColor = Color(#colorLiteral(red: 0.1490196078, green: 0.3607843137, blue: 0.9960784314, alpha: 0.9672237169))
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                // Background
                backgroundColor
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    // Title & Subtitle
                    VStack(spacing: 10) {
                        Text("Clinic Flow")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Your clinic visit, organized\nand Simplified")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                    }
                    
                    Spacer()
                    
                    // Get Started Button
                    NavigationLink(destination: InstructOneView()) {
                        
                        HStack(spacing: 12) {
                            Image("ic_landing")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 36, height: 36)
                            
                            Text("Get Started")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 22)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50)
                    }
                    .padding(.horizontal, 39)
                    .padding(.bottom, 48)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LandingView()
}
