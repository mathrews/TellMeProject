//
//  PostFeed.swift
//  TellMeProject
//
//  Created by found on 09/12/25.
//

import SwiftUI

struct PostFeed: View {
    @State var isLiked = false
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(Color.white)
                Text("@John Doe")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
                .padding(.bottom, 4)
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: 500)
                .foregroundStyle(Color.white)
                .padding(.bottom, 4)
            HStack {
                HStack {
                    Text("Hour")
                        .foregroundStyle(Color.gray)
                    Text("-")
                        .foregroundStyle(Color.gray)
                    Text("Date")
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Image(systemName: "info.circle")
                    .foregroundStyle(Color.gray)
            }
            .padding(.bottom, 4)
            Divider()
                .overlay(Rectangle().frame(height: 1).foregroundColor(.white))
                .padding(.bottom, 4)
            HStack {
                HStack {
                    Image(systemName: "heart")
                        .foregroundStyle(Color.gray)
                    Text("0")
                        .foregroundStyle(Color.gray)
                }
                HStack {
                    Image(systemName: "message")
                        .foregroundStyle(Color.gray)
                    Text("Reply")
                        .foregroundStyle(Color.gray)
                }
                HStack {
                    Image(systemName: "link")
                        .foregroundStyle(Color.gray)
                    Text("Copy Link")
                        .foregroundStyle(Color.gray)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    PostFeed()
}
