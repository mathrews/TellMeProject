//
//  PostFeed.swift
//  TellMeProject
//
//  Created by found on 09/12/25.
//

import SwiftUI

struct PostFeed: View {
    var profileImage: String
    var profileName: String
    var postImage: String
    var hour: Date
    var date: Date
    
    @State var isLiked = false
    @State var likeCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Image(profileImage)
                    .resizable()
                    .scaledToFit() // Or .scaledToFit()
                    .frame(width: 32, height: 32) // Set desired frame size
                    .clipShape(Circle())
                Text(profileName)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
                Spacer()
            }
                .padding(.bottom, 4)
            Image(postImage)
                .resizable()
                .scaledToFit() // Or .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 400) // Set desired frame size
                .clipShape(RoundedRectangle(cornerRadius: 20))
            HStack {
                HStack {
                    Text(hour.formatted(date: .abbreviated, time: .omitted))
                        .foregroundStyle(Color.gray)
                    Text("-")
                        .foregroundStyle(Color.gray)
                    Text(date.formatted(date: .omitted, time: .shortened))
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Button(action: {
                    print("Show Infos")
                }) {
                    Image(systemName: "info.circle")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                        .font(.title3)
                }
            }
            .padding(.bottom, 2)
            Divider()
                .overlay(Rectangle().frame(height: 1).foregroundColor(.white))
                .padding(.bottom, 4)
            HStack {
                HStack {
                    Button(action: {
                        if !isLiked {
                            likeCount += 1
                        } else if isLiked {
                            likeCount -= 1
                        }
                        isLiked.toggle()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundStyle(isLiked ? Color(hex: "FA1980") : Color.gray)
                    }
                    Text("\(likeCount)")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                }
                HStack {
                    Button(action: {
                        print("Subir Sheet")
                    }) {
                        Image(systemName: "message")
                            .foregroundStyle(Color.gray)
                    }
                    Text("Reply")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                Button(action: {
                    print("Copy Link")
                }) {
                    HStack {
                        Image(systemName: "link")
                            .foregroundStyle(Color.gray)
                        Text("Copy Link")
                            .foregroundStyle(Color.gray)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    PostFeed(profileImage: "Radioheadthebends", profileName: "@TomYorke", postImage: "TomYorke", hour: Date.now, date: Date.now)
}
