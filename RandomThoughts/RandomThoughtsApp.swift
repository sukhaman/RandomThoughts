//
//  RandomThoughtsApp.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import SwiftUI

@main
struct RandomThoughtsApp: App {
    @StateObject private var authenticationManager = AuthenticationManager()
    var body: some Scene {
        WindowGroup {
            DealDetailView(addressList: AddressList(list: [Address(id: 123, primaryAddress: true, streetAddress: "1234 Prospect Street", suite: nil, city: "Norwalk", state: "NY", zipcode: "12345", housingstatus: "Rent", durationYears: 2, durationMonths: 2, monthlyPayment: "1234.55"),Address(id: 123, primaryAddress: true, streetAddress: "14 Summer Street", suite: nil, city: "Stamford", state: "NY", zipcode: "06903", housingstatus: "", durationYears: 3, durationMonths: 2, monthlyPayment: "2234.55"),Address(id: 123, primaryAddress: true, streetAddress: "34 Other Street", suite: nil, city: "Bridgeport", state: "NY", zipcode: "06604", housingstatus: "", durationYears: 4, durationMonths: 2, monthlyPayment: "3234.55")]))
             //SplashView()
                //.environmentObject(authenticationManager)
        }
    }
}


struct SplashView: View {
    @State private var isSplashScreenActive = true
    @State private var rotationAngle: Double = 0
    @StateObject private var loginViewModel = LoginViewModel(MockLoginService())
    var body: some View {
        Group {
            if isSplashScreenActive {
                // Splash screen content
                Image(systemName: "star.fill")
                            .font(.system(size: 100))
                            .rotationEffect(.degrees(rotationAngle))
                            .onAppear {
                                withAnimation(Animation.linear(duration: 5)) {
                                    rotationAngle += 360
                                }
                                
                                // Simulate a delay for the splash screen
                                DispatchQueue.main.asyncAfter(deadline: .now() + 35) {
                                    withAnimation {
                                        isSplashScreenActive = false
                                    }
                                }
                            }
                            .opacity(isSplashScreenActive ? 1 : 0)
            } else {
                // Main content after splash screen
                LoginView(viewModel: LoginViewModel(MockLoginService()))
                
               
                
            }
        }
        .onAppear {
            // Simulate a delay for the splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isSplashScreenActive = false
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
