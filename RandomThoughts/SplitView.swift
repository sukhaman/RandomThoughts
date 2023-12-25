//
//  SplitView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/23/23.
//

import SwiftUI

struct SplitView: View {
    var user: User
    var body: some View {
        NavigationView {
            MasterView()
            
            Text("Welcome \(user.username) select a deal")
                .foregroundColor(.secondary)
            
            DetailView()
        }
    }
}

struct MasterView: View {
    var body: some View {
        List {
            NavigationLink(destination: DetailView()) {
                Text("Item 1")
            }
            
            NavigationLink(destination: DetailView()) {
                Text("Item 2")
            }
            
            // Add more items as needed
        }
        .listStyle(SidebarListStyle()) // SidebarListStyle gives a master-detail interface feel on iPad
        .navigationTitle("Master")
    }
}

struct DetailView: View {
    let sections = [
        SectionData(title: "Section 1",imageName: "house.fill", items: [ RowData(content: "Short Row", height: 50),
                                                 RowData(content: "Medium Row", height: 50),
                                                 RowData(content: "Tall Row", height: 50)]),
        SectionData(title: "Section 2",imageName: "house.fill", items: [ RowData(content: "Short Row", height: 85),
                                                 RowData(content: "Medium Row", height: 85),
                                                 RowData(content: "Tall Row", height: 85)]),
        // Add more sections as needed
    ]

    var body: some View {
        GeometryReader { geometry in
        List {
            ForEach(sections.indices, id: \.self) { sectionIndex in
                Section(header: CustomHeaderView(title: sections[sectionIndex].title, imageName: sections[sectionIndex].imageName, buttonAction: {
                    print("Button tapped for section \(sectionIndex)")
                })) {
                    ForEach(sections[sectionIndex].items.indices, id: \.self) { rowIndex in
                        RowView(rowData: sections[sectionIndex].items[rowIndex], width: geometry.size.width)
                            .onTapGesture {
                                print("Row tapped at section \(sectionIndex) row \(rowIndex)")
                            }
                    }
                
                    
                }
            }
            
        }
            
    }
        
        .listStyle(InsetGroupedListStyle()) // Use a different list style if needed
        .navigationTitle("Detail")
        NavigationLink("Navigate to New View", destination: NewView())
                      .padding()
    }
    
}

struct NewView: View {
    var body: some View {
        Text("New View Content")
            .navigationTitle("New View")
    }
}

#Preview {
    SplitView(user: User(id: 2, firstName: "tres", lastName: "tres", username: "gjh", email: "gghj"))
}
