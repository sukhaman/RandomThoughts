//
//  ContentView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/22/23.
//

import SwiftUI

struct ContentView: View {
    let sections = [
        SectionData(title: "Section 1",imageName: "house.fill", items: [ RowData(content: "Short Row", height: 50),
                                                 RowData(content: "Medium Row", height: 50),
                                                 RowData(content: "Tall Row", height: 50)]),
        SectionData(title: "Section 2",imageName: "person.fill", items: [ RowData(content: "Short Row", height: 85),
                                                 RowData(content: "Medium Row", height: 85),
                                                 RowData(content: "Tall Row", height: 85)]),
        // Add more sections as needed
    ]
    @State private var isSectionTapped = false
    @State private var selectedSection = 0
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                List {
                    ForEach(sections.indices, id: \.self) { sectionIndex in
                        Section(header: CustomHeaderView(title: sections[sectionIndex].title, imageName: sections[sectionIndex].imageName, buttonAction: {
                            print("Button tapped for section \(sectionIndex)")
                            selectedSection = sectionIndex
                            isSectionTapped = true
                        })) {
                            ForEach(sections[sectionIndex].items) { item in
                                RowView(rowData: item, width: geometry.size.width)
                            }
                            .listRowInsets(EdgeInsets())
                            
                        }
                    }
                }
                .listRowInsets(EdgeInsets())
                
                /*
                .fullScreenCover(isPresented: $isSectionTapped, content: {
                    SectionDetailView(onDismiss: {
                        // Handle dismissal if needed
                        isSectionTapped = false
                    }, section: sections[selectedSection])
                })
                */
                
              //  .listStyle(InsetGroupedListStyle()) // Use a different list style if needed
            }
            .navigationViewStyle(.stack)
        }
        
    }
    
    
}
 
struct SectionDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var onDismiss: () -> Void
    var section: SectionData
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                
                Button("Cancel") {
                    // Dismiss the view
                    presentationMode.wrappedValue.dismiss()

                    // Optionally, call the onDismiss callback
                    onDismiss()
                }
                Spacer()
                Text("Programming Love!")
                    .font(.subheadline)
                    .bold()
                Spacer()
            }
            .padding()

            QuestionView()
            Spacer()
        }
        .navigationTitle("Next View")
    }
}


struct RowView: View {
    var rowData: RowData
    var width: CGFloat
    var body: some View {
        VStack {
            Text(rowData.content)
                .frame(width: width, height: rowData.height)
                .font(.headline)
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
        }
        .listRowInsets(EdgeInsets())
        .background(Color.clear)
    }
}

struct CustomHeaderView: View {
    var title: String
    var imageName: String
    var buttonAction: () -> Void
    var body: some View {
        HStack {
            
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20,height: 20)
                .padding()
            Text(title)
                .font(.headline)
                .padding(.leading)
            Spacer()
            Button(action: {
                self.buttonAction()
            }, label: {
                Text("ADD")
                    .foregroundColor(.white)
                                       .padding(8)
                                       .background(Color.blue)
                                       .cornerRadius(8)
            })
            .padding()
            
        }
        .frame(maxWidth: .infinity,maxHeight: 60)
        .background(Color.blue.opacity(0.2)) // Customize the header background color
        .padding()
    }
}

struct CustomCellView: View {
    var item: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(item)
                .font(.body)
                .padding(8)
        }
        .background(Color.white) // Customize the cell background color
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

struct SectionData: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var imageName: String
    var items: [RowData]
}
struct RowData: Identifiable, Hashable {
    var id = UUID()
    var content: String
    var height: CGFloat
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


