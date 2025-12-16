//
//  ContentView.swift
//  TellMeProject
//
//  Created by found on 05/12/25.
//

import SwiftUI
import SwiftUIExtras

struct GalleryView: View {
    init() {
        let appearance = UINavigationBarAppearance()

        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    let topID = "top"  // A unique ID for the top of the view
    // A state variable to hold the ID of the first visible item
    @State private var firstItemID: Int? = 0
    // A state variable to track if the view should be visible
    @State private var showButtonTop = false

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ZStack(alignment: .bottomTrailing) {
                    ScrollView {
                        Color.clear.frame(height: 0).id(topID)

                        HStack {
                            Spacer()
                            
                            Text("Galery")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            NavigationLink(destination: UploadView()) {
                                Image(systemName: "plus")
                                    .padding(6)  // Add padding around the content
                                    .background(Color.black)  // Background color of the button
                                    .foregroundColor(.white)  // Text and icon color
                                    .fontWeight(.bold)
                                    .cornerRadius(100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 100)  // The border shape
                                            .stroke(Color.white, lineWidth: 2)  // Border color and thickness
                                    )
                            }
                            .navigationTitle("Upload")
                            // Add buttons or other UI elements here
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(hex: "212328").ignoresSafeArea())

                        VStack {
                            ForEach(0...50) { _ in
                                PostFeed()
                            }
                        }
                        .scrollTargetLayout()
                    }
                    // Bind the scroll position to the state variable
                    .scrollPosition(id: $firstItemID)
                    // Observe changes to the first visible item ID
                    .onChange(of: firstItemID) { oldValue, newValue in
                        // If the first visible item's ID is not 0 (the top item), show the indicator
                        withAnimation(.easeInOut) {
                            showButtonTop = (newValue != 0)
                        }
                    }

                    if showButtonTop {
                        Button(action: {
                            withAnimation(.easeInOut) {  // Adds smooth scrolling animation
                                proxy.scrollTo(topID, anchor: .top)  // Scrolls to the topID with top alignment
                            }
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 40)  // Adjust position to avoid iOS Home Indicator
                    }

                }
            }
            .toolbar(.hidden, for: .navigationBar)  // Hide the default system navigation bar
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
        }
    }
}

#Preview {
    GalleryView()
}
