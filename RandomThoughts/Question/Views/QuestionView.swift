//
//  QuestionView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/24/23.
//

import SwiftUI

struct QuestionView: View {
    @State private var selectedOption: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("What is your favorite programming language?")
                .font(.headline)
                .padding()

            Button(action: {
                selectedOption = "Swift"
            }) {
                OptionView(option: "Swift", isSelected: selectedOption == "Swift")
            }

            Button(action: {
                selectedOption = "JavaScript"
            }) {
                OptionView(option: "JavaScript", isSelected: selectedOption == "JavaScript")
            }

            Button(action: {
                selectedOption = "Python"
            }) {
                OptionView(option: "Python", isSelected: selectedOption == "Python")
            }

            Spacer()

            if let selectedOption = selectedOption {
                Text("Selected Option: \(selectedOption)")
                    .padding()
            }
        }
        .padding()
        .navigationBarTitle("Questionnaire")
    }
}

struct OptionView: View {
    let option: String
    let isSelected: Bool

    var body: some View {
        HStack {
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .blue : .gray)
                .imageScale(.large)
                .padding()

            Text(option)
                .foregroundColor(.primary)
                .font(.body)
                .padding()
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}

#Preview {
    QuestionView()
}
