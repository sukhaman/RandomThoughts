//
//  AddressView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/25/23.
//

import SwiftUI


struct AddressView: View {
    @State private var selectedSegment = 0
    @State var addressList: AddressList
    @State var address: Address
    @State var viewHeight: CGFloat = 345.0
    @State var addressViewHeight: CGFloat = 150
    let segments = ["Current Address", "Previous", "Second Previous"]
    var body: some View {
        GeometryReader { geometryReader in
            ZStack {
               
                VStack {
                    
                    AddressHeaderView()
                    AddressSegmentView { value in
                        address = addressList.list[value]
                        selectedSegment = value
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if value == 0 {
                                viewHeight = 345
                                addressViewHeight = 150
                            } else {
                                viewHeight = 315
                                addressViewHeight = 100
                            }
                        }
                    }
                    RegisteredAddressView()
                        .opacity(selectedSegment == 0 ? 1 : 0)
                    AddressSecondaryView(address:address, height: addressViewHeight, width: geometryReader.size.width)
                        .offset(y: selectedSegment == 0 ? 0 : -40)
                    
                }
                .frame(height: viewHeight)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
                .border(Color.black)
            }
        }
    }
}



/*
struct AddressView: View {
    @State var addressList: AddressList
    @State var address: Address
    @State var selectedSegment = 0
    @State var viewHeight: CGFloat = 345.0
    @State var addressViewHeight: CGFloat = 150
    let options = ["Current Address", "Previous", "Second Previous"]
    var body: some View {
        
        ZStack {
            GeometryReader { geometryReader in
                VStack {
                    
                    HStack {
                                Image(systemName: "house.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 30))

                                Text("ADDRESS INFORMATION")
                                    .font(.body)
                                    

                                Spacer()

                                Button(action: {
                                    // Handle button action
                                }) {
                                    Text("UPDATE")
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                }
                            }
                    .frame(maxWidth: geometryReader.size.width, maxHeight: 40)
                    .background(Color.white)
                    .padding()
                    Picker("", selection: $selectedSegment) {
                        ForEach(0..<options.count, id: \.self) {
                            Text(options[$0])
                            
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: selectedSegment) { addressIndex in
                        self.address = addressList.list[selectedSegment]
                        // Perform your action when the picker value changes
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if selectedSegment == 0 {
                                viewHeight = 345
                                addressViewHeight = 150
                            } else {
                                viewHeight = 315
                                addressViewHeight = 100
                            }
                        }
                    }
                    HStack(spacing:6) {
                        Image(systemName: "checkmark.square")
                            .foregroundColor(.yellow)
                            .padding()
                            .opacity(selectedSegment != 0 ? 0 : 1)
                        Text(" Register to Address")
                            .foregroundStyle(Color.green)
                            .font(.title2)
                            .opacity(selectedSegment != 0 ? 0 : 1)
                        Spacer()
                    }
                    
                    .frame(width: geometryReader.size.width, height: 25, alignment: .center)
                    // .frame(width: geometryReader.size.width, height: 30, alignment: .center)
                    AddressSecondaryView(address:address, height: addressViewHeight, width: geometryReader.size.width)
                }
                .frame(maxWidth: geometryReader.size.width,maxHeight: viewHeight)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 3)
                
                
                
                
                
            }
            .padding()
            .ignoresSafeArea(.all)
            .background(Color.white)
            //.frame(width: geometryReader.size.width, height: geometryReader.size.height, alignment: .center)
        }
        
    }
}
*/

#Preview {
    AddressView(addressList: AddressList(list: []), address: Address(id: 123, primaryAddress: true, streetAddress: "1234 Prospect Street", suite: nil, city: "Norwalk", state: "NY", zipcode: "12345", housingstatus: "Rent", durationYears: 2, durationMonths: 2, monthlyPayment: "1234.55"))
}

struct SegmentedControlView: View {
    var selectedSegment: Int = 0
    private let segments = ["First", "Second", "Third"]
    var width: CGFloat
    var buttonAction: (_ index: Int) -> Void
    var body: some View {
        
        HStack(spacing:0) {
            ForEach(0..<segments.count,id:\.self) { index in
                Button(action: {
                    self.buttonAction(index)
                }) {
                    Text(segments[index])
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(selectedSegment == index ? Color.blue : Color.white)
                        .foregroundColor(selectedSegment == index ? Color.white : Color.black)
                    
                }
            }
        }
        .frame(width:width,height:50)
        
    }
}

struct AddressSecondaryView: View {
    var address: Address
    var height: CGFloat
    var width: CGFloat
    var body: some View {
        GeometryReader { geometryReader in
            VStack {
            HStack(alignment: .center,spacing: 6) {
                Text("Street Address:")
                    .font(.headline)
                    .padding(5)
                Text(address.showCompleteAddress())
                    .font(.body)
                    .lineLimit(2)
                Spacer()
            }
            .frame(width:width - 5,height: 50)
                HStack(alignment: .center,spacing: 6) {
                    Text("Housing Status")
                        .font(.headline)
                        .padding(5)
                    Text(address.housingstatus)
                        .font(.body)
                    Spacer()
                }
                HStack(alignment: .center,spacing: 6) {
                    Text("Time at address:")
                        .font(.headline)
                        .padding(5)
                    Text(address.showTimeAtAddress())
                        .font(.body)
                    Spacer()
                }
                HStack(alignment: .center,spacing: 6) {
                    Text("Monthly Payment:")
                        .font(.headline)
                        .padding(5)
                    Text(address.showMonthlyPaymentWIthCurrency())
                        .font(.body)
                    Spacer()
                }
                .frame(width: width)
        }
            .frame(maxWidth: width, maxHeight: height)
        .padding()
        }
    }
}

struct AddressHeaderView: View {
    var body: some View {
        HStack(spacing:16) {
            Image(systemName: "star.circle.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 30))
            
            Text("ADDRESS INFORMATION")
                .font(.headline)
                .lineLimit(1)
                .fixedSize(horizontal: true, vertical: false)
            
            Button(action: {
                // Handle button action
            }) {
                Text("Update")
                    .foregroundColor(.white)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: 40)
    }
}

struct AddressSegmentView: View {
    @State private var selectedSegment = 0
    let segments = ["Current Address", "Previous", "Second Previous"]
    var buttonAction: (Int) -> Void
    var body: some View {
        Picker("Select an option", selection: $selectedSegment) {
            ForEach(0..<segments.indices.count,id:\.self) {
                Text(segments[$0])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedSegment) { newValue in
            self.buttonAction(newValue)
        }

    }
}

struct RegisteredAddressView: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.square")
                .font(.title)
                .foregroundColor(.yellow)
                .padding()
                Text("Action will be done")
                    .foregroundColor(.yellow)
            Spacer()
                    
        }
    }
}
