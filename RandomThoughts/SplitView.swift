//
//  SplitView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/23/23.
//

import SwiftUI


struct Raindrop: View {
    @State private var position: CGFloat = 0
    @State private var opacity: Double = 1

    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 5, height: 15)
            .offset(y: position)
            .opacity(opacity)
            .onAppear {
                animateRaindrop()
            }
    }

    func animateRaindrop() {
        withAnimation(Animation.linear(duration: 2).repeatForever()) {
            position = 600 // Adjust this value based on your screen size
            opacity = 0
        }
    }
}

struct RainContentView: View {
    var body: some View {
        ZStack {
            // Background representing the sky
            Color.gray
                .ignoresSafeArea()

            // Raindrops falling animation
            ForEach(0..<1540) { _ in
                Raindrop()
                    .offset(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...600))
            }
        }
    }
}






struct SplitView: View {
    var user: User
    var dealList: DealList
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var preferredColumn = NavigationSplitViewColumn.content
    var body: some View {
        
        
        NavigationSplitView(columnVisibility: $visibility,sidebar: {
            MasterView(dealList: dealList)
                           .toolbar(.hidden, for: .navigationBar)
        },detail: {
            DealDetailView(addressList: AddressList(list: [Address(id: 123, primaryAddress: true, streetAddress: "1234 Prospect Street", suite: nil, city: "Norwalk", state: "NY", zipcode: "12345", housingstatus: "Rent", durationYears: 2, durationMonths: 2, monthlyPayment: "1234.55"),Address(id: 123, primaryAddress: true, streetAddress: "14 Summer Street", suite: nil, city: "Stamford", state: "NY", zipcode: "06903", housingstatus: "", durationYears: 3, durationMonths: 2, monthlyPayment: "2234.55"),Address(id: 123, primaryAddress: true, streetAddress: "34 Other Street", suite: nil, city: "Bridgeport", state: "NY", zipcode: "06604", housingstatus: "", durationYears: 4, durationMonths: 2, monthlyPayment: "3234.55")]))
                .toolbar(.visible, for: .navigationBar)
                
        })
                .navigationSplitViewStyle(.balanced)
    }
    
}


struct MasterHeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)

                Spacer() // Add spacing between the images

                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
            }
            .padding()

            VStack {
                Text("Hello, SwiftUI!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)

                Text("This is a simple example.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Spacer() // Add spacing at the bottom
        }
    }
}

struct MasterView: View {
    var dealList: DealList
    var body: some View {
        NavigationStack {
                ZStack {
                    GeometryReader { reader in
                    VStack {
                        HStack {
                            Spacer(minLength: 5)
                            VStack {
                                Text("Random Thoughts")
                                    .font(.title2)
                            }
                            .frame(maxWidth: reader.size.width * 0.75,maxHeight:50)
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(.blue) // Background color
                                    .shadow(radius: 10) // Shadow effect
                                
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white) // Color of the person fill image
                                    .frame(width: 30, height: 30)
                            }
                            .frame(width: 50,height: 50)
                           Spacer(minLength: 5)
                        }
                        .frame(maxWidth: reader.size.width,maxHeight:70)
                        .padding()
                        VStack {
                            List {
                                ForEach(0..<dealList.results.count, id: \.self) { index in
                                    Text(dealList.results[index].status)
                                    
                                }
                            }
                            .background(Color.clear)
                            
                        }
                    }
                    .frame(height: reader.size.height)
                   
                }
                .background(Color.white)
                
            }
        }
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
    SplitView(user: User(id: 3, firstName: "First", lastName: "Last", username: "Usernam", email: "emai@test.com"), dealList: DealList(results: [Deal(id: 1, status: "active", buyer: User(id: 3, firstName: "First", lastName: "Last", username: "Usernam", email: "emai@test.com"))]))
}
