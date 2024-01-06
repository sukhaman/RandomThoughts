//
//  EmploymentView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/27/23.
//

import SwiftUI

struct EmploymentView: View {
    @State private var selectedSegment = 0
    @State var employmentList: EmploymentList
    @State var employment: Employment
    @State var viewHeight: CGFloat = 345.0
    @State var addressViewHeight: CGFloat = 150
    let segments = ["Current", "Previous", "Second Previous"]
    var body: some View {
        GeometryReader { geometryReader in
            ZStack {
               
                VStack {
                    
                    HeaderView(iconName: "star.circle.fill", title: "EMPLOYMENT INFORMATION", buttonTitle: employmentList.list.count == 0 ? "ADD" : "UPDATE", buttonAction: {
                        
                    })
                    SegmentView { value in
                        employment = employmentList.list[value]
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
                    EmploymentSecondaryView(employment: employment, height: 450, width: geometryReader.size.width)
                        .offset(y: selectedSegment == 0 ? 0 : -40)
                  //  AddressSecondaryView(address:address, height: addressViewHeight, width: geometryReader.size.width)
                      //  .offset(y: selectedSegment == 0 ? 0 : -40)
                    
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


struct EmploymentSecondaryView: View {
    var employment: Employment
    var height: CGFloat
    var width: CGFloat
    var body: some View {
        GeometryReader { geometryReader in
            VStack {
                HStack(alignment: .center,spacing: 6) {
                    Text("How do you get paid?")
                        .font(.headline)
                        .padding(5)
                    Text(employment.paidType ?? "-")
                        .font(.body)
                    Spacer()
                }
                HStack(alignment: .center,spacing: 6) {
                    Text("Employment Status")
                        .font(.headline)
                        .padding(5)
                    Text(employment.status ?? "")
                        .font(.body)
                    Spacer()
                }
                HStack(alignment: .center,spacing: 6) {
                    Text("Employer Name")
                        .font(.headline)
                        .padding(5)
                    Text(employment.name)
                        .font(.body)
                    Spacer()
                }
                HStack(alignment: .center,spacing: 6) {
                    Text("Occupation")
                        .font(.headline)
                        .padding(5)
                    Text(employment.jobTitle)
                        .font(.body)
                    Spacer()
                }
                HStack(alignment: .center,spacing: 6) {
                    Text("Phone Number")
                        .font(.headline)
                        .padding(5)
                    Text(employment.phoneNumber ?? "-")
                        .font(.body)
                    Spacer()
                }

            HStack(alignment: .center,spacing: 6) {
                Text("Employer Address:")
                    .font(.headline)
                    .padding(5)
                Text(employment.showEmployerCompleteAddress())
                    .font(.body)
                    .lineLimit(2)
                Spacer()
            }
            .frame(maxWidth:.infinity,maxHeight: 50)
                HStack(alignment: .center,spacing: 6) {
                    Text("Employment Duration")
                        .font(.headline)
                        .padding(5)
                    Text(employment.employmentDuration())
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

#Preview {
    EmploymentView(employmentList: EmploymentList(list: [Employment(id: 12, name: "Red Apple, Inc", jobTitle: "Non-Relvant", address: "123 Main Street", suite: "Apt 1", city: "New Town", state: "NY", zipcode: "12345", grossIncome: "12345", salaryType: "Check", status: "Employed", durationYears: 2, durationMonths: 2, phoneNumber: "1234123123", paidType: "weekly")]), employment: Employment(id: 12, name: "Red Apple, Inc", jobTitle: "Non-Relvant", address: "123 Main Street", suite: "Apt 1", city: "New Town", state: "NY", zipcode: "12345", grossIncome: "12345", salaryType: "Check", status: "Employed", durationYears: 2, durationMonths: 2, phoneNumber: "1234123123", paidType: "weekly"))
}
