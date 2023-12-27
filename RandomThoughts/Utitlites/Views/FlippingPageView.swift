//
//  FlippingPageView.swift
//  RandomThoughts
//
//  Created by Sukhaman Singh on 12/26/23.
//

import SwiftUI

import SwiftUI

struct FlippingPageView: View {
    @State private var isShowing = false
    var body: some View {
            VStack {
                Spacer()

                ZStack {
                    if isShowing {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                            .frame(width: 200, height: 100)
                            .transition(.move(edge: .trailing))
                    }
                }

                Button("Show View") {
                    withAnimation {
                        isShowing.toggle()
                    }
                }
                .padding()

                Spacer()
            }
            .background(Color.gray.edgesIgnoringSafeArea(.all))
        }
    }


struct PageView: View {
    let content: String
    @Binding var isFlipped: Bool

    var body: some View {
        VStack {
            Text(content)
                .font(.title)
                .foregroundColor(.white)
                .padding()

            Spacer()

            Image(systemName: "book.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .padding()

            Spacer()
        }
        .background(isFlipped ? Color.green : Color.blue)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(20)
        .frame(width: 200, height: 300)
        .rotationEffect(.degrees(isFlipped ? 180 : 0))
        .offset(x: isFlipped ? -200 : 0, y: 0)
    }
}


#Preview {
    FlippingPageView()
}
