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
        
        ScrollView {
            ZStack {
                VStack(spacing:20) {
                    VStack {
                        AddressView(addressList: AddressList(list: addressList.list), address: Address(id: 123, primaryAddress: true, streetAddress: "134 Prospect Street", suite: nil, city: "Norwalk", state: "NY", zipcode: "12345", housingstatus: "Rent", durationYears: 2, durationMonths: 2, monthlyPayment: "834.15"))
                            
                        
                            .frame(height: 380)
                            .padding()
                        

                    }
                }
                
            }
        }
    }
}

#Preview {
    DealDetailView(addressList: AddressList(list: []))
}
