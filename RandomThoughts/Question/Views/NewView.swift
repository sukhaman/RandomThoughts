//
//  NewView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/24/23.
//

import SwiftUI

struct ContentsView: View {
    let sections = [
        SectionData(title: "Section 1",imageName: "house.fill", items: [ RowData(content: "Short Row", height: 50),
                                                 RowData(content: "Medium Row", height: 50)]),
        SectionData(title: "Section 2",imageName: "person.fill", items: [ RowData(content: "Short Row", height: 85),
                                                 RowData(content: "Medium Row", height: 85),
                                                 RowData(content: "Tall Row", height: 85)]),
        // Add more sections as needed
    ]
    @State private var isSectionTapped = false
    @State private var selectedSection = 0
    var body: some View {
        List {
            Section(header: headerView("Section 1")) {
                            ForEach(1..<5) { index in
                                rowView("Row \(index)")
                            }
                        }
            /*
            Section(header: Text("Section 1")) {
                ForEach(1..<5) { index in
                    Text("Row \(index)")
                        .padding()
                }
            }
            .textCase(nil) // To prevent automatic capitalization of section header

            Section(header: Text("Section 2")) {
                ForEach(5..<10) { index in
                    Text("Row \(index)")
                        .padding()
                }
            }
            .textCase(nil) // To prevent automatic capitalization of section header
            */
        }
        .listRowInsets(EdgeInsets()) // Remove space between rows and sections
    }
    
    func headerView(_ title: String) -> some View {
         VStack {
             Text(title)
                 .font(.headline)
                 .frame(maxWidth: .infinity, alignment: .leading)
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .background(Color.gray) // Optional: background color for section header
     }
    
    func rowView(_ text: String) -> some View {
            Text(text)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white) // Optional: background color for list row
        }
}

struct ContentsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
    }
}
