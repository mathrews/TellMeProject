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
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("Main Content")
            }
            .navigationTitle("Gallery").navigationBarTitleDisplayMode(.inline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
                }
            }
        }
    }
}

#Preview {
    GalleryView()
}
