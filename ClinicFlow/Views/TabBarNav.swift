//
//  TabBarNav.swift
//  ClinicFlow
//
//  Created by M H T U De Silva on 2026-02-24.
//

import SwiftUI

struct TabBarNav: View {
    @StateObject private var tabManager = TabBarViewModel()

    var body: some View {
        if #available(iOS 18, *) {
            ZStack(alignment: .bottom) {

                NavigationStack(path: $tabManager.navigationPath) {
                    TabView(selection: $tabManager.activeTab) {
                        Tab(value: .home) {
                            HomeView()
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab(value: .location) {
                            Text("Map")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab(value: .activity) {
                            Text("activity")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                        Tab(value: .account) {
                            Text("account")
                                .toolbarVisibility(.hidden, for: .tabBar)
                        }
                    }
                    .toolbarVisibility(.hidden, for: .tabBar)
                    .navigationDestination(for: NavigationRoute.self) { route in
                        switch route {
                        case .consultation:
                            ConsultationView()
                        case .appointmentDashboard:
                            AppointmentDashboardView()
                        case .pharmacy:
                            PharmacyView()
                        case .lab:
                            LabView()
                        case .emergencyLab:
                            EmergencyLabView()
                        case .specialtyTab(let specialty):
                            SpecialtyTabView(preselectedSpecialty: specialty)
                        case .doctorDetail(let doctor):
                            DoctorDetailView(doctor: doctor)
                        case .bookAppointment(let doctor):
                            BookAppointmentView(doctor: doctor)
                        case .addPatient(let doctor):
                            AddPatientView(doctor: doctor)
                        case .appointmentDetail(let booking):
                            AppointmentDetailsView(booking: booking)
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }

//                CustomTabBar(activeTab: $tabManager.activeTab)
//                    .shadow(color: .black.opacity(0.15), radius: 10)
//                    .padding(.bottom, 8)
                
                if !tabManager.isTabBarHidden {
                    CustomTabBar(activeTab: $tabManager.activeTab)
                        .shadow(color: .black.opacity(0.15), radius: 10)
                        .padding(.bottom, 8)
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .environmentObject(tabManager)
        }
    }
}

// MARK: - UIView Extension
extension UIView {
    var tabController: UITabBarController? {
        if let controller = sequence(first: self, next: { $0.next })
            .first(where: { $0 is UITabBarController }) as? UITabBarController {
            return controller
        }
        return nil
    }
}

#Preview {
    TabBarNav()
        .environmentObject(TabBarViewModel())
}
