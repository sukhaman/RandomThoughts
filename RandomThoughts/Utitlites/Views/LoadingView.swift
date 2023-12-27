//
//  LoadingView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/25/23.
//

import SwiftUI

struct LoadingView: View {
    let message: String

    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0) // Adjust the scale as needed

            Text(message)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}



#Preview {
    LoadingView(message: "Loading")
}
