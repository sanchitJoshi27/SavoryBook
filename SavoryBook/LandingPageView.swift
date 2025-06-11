//
//  LandingPageView.swift
//  SavoryBook
//
//  Created by Sanchit Joshi on 6/5/25.
//

import SwiftUI

struct LandingPageView: View {
    @State private var isNavigating = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("BG")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()

                VStack(alignment: .center, spacing: 30) {
                    Image("logo")
                        .resizable()
                        .frame(width: 75, height: 75)

                    VStack(alignment: .trailing, spacing: 10) {
                        Text("SavoryBook")
                            .bold()
                            .foregroundColor(.orange)
                            .font(.custom("Papyrus", size: 50))
                            .gradientForeground(colors: [Color.orange, Color.pink])


                        Button(action: {
                            withAnimation {
                                isNavigating = true
                            }
                        }) {
                            Text("Let's Get Cooking...")
                                .font(.custom("Papyrus-Condensed", size: 30))
                                .gradientForeground(colors: [Color.orange, Color.pink])
                        }
                        .buttonStyle(.bordered)
                        .padding(.leading)
                        
               
                        .navigationDestination(isPresented: $isNavigating) {
                            RecipePageView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LandingPageView()
}
