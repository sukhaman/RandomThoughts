//
//  DealDetailView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/26/23.
//

import SwiftUI

struct DealDetailView: View {
    @State var addressList: AddressList
    var body: some View {
        
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack(spacing:20) {
                        VStack {
                            AddressView(addressList: AddressList(list: addressList.list), address: Address(id: 123, primaryAddress: true, streetAddress: "134 Prospect Street", suite: nil, city: "Norwalk", state: "NY", zipcode: "12345", housingstatus: "Rent", durationYears: 2, durationMonths: 2, monthlyPayment: "834.15"))
                                
                            
                                .frame(height: 380)
                                .padding()
                            

                        }
                        
                        VStack {
                            EmploymentView(employmentList: EmploymentList(list: [Employment(id: 12, name: "Red Apple, Inc", jobTitle: "Non-Relvant", address: "123 Main Street", suite: "Apt 1", city: "New Town", state: "NY", zipcode: "12345", grossIncome: "12345", salaryType: "Check", status: "Employed", durationYears: 2, durationMonths: 2, phoneNumber: "1234123123", paidType: "weekly")]), employment: Employment(id: 12, name: "Red Apple, Inc", jobTitle: "Non-Relvant", address: "123 Main Street", suite: "Apt 1", city: "New Town", state: "NY", zipcode: "12345", grossIncome: "12345", salaryType: "Check", status: "Employed", durationYears: 2, durationMonths: 2, phoneNumber: "1234123123", paidType: "weekly"))
                                
                            
                                .frame(height: 380)

                        }
                        .padding()
                    }
                    
                }
            }
        }
        .navigationTitle("Title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DealDetailView(addressList: AddressList(list: []))
}
