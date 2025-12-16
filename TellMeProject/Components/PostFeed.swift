//
//  PostFeed.swift
//  TellMeProject
//
//  Created by found on 09/12/25.
//

import SwiftUI
import SwiftUIExtras

struct PostFeed: View {
    var profileImage: String = "Radioheadthebends"
    var profileName: String = "@TomYorke"
    var postImage: String = "TomYorke"
    var hour: Date = Date.now
    var date: Date = Date.now

    @State var isLiked = false
    @State var likeCount = 0
    @State var showSheetComments = false
    @State var showSheetInfos = false
    
    var body: some View {
        VStack {
            HStack {
                Image(profileImage)
                    .resizable()
                    .scaledToFit()  // Or .scaledToFit()
                    .frame(width: 32, height: 32)  // Set desired frame size
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
                .scaledToFit()  // Or .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 400)  // Set desired frame size
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
                    showSheetInfos.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                        .font(.title3)
                }
                .sheet(isPresented: $showSheetInfos) {
                    InfosSheetView()
                        .presentationBackground(Color(hex: "212328"))
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
                            .foregroundStyle(
                                isLiked ? Color(hex: "FA1980") : Color.gray)
                    }
                    Text("\(likeCount)")
                        .foregroundStyle(Color.gray)
                        .fontWeight(.bold)
                }
                HStack {
                    Button(action: {
                        print("Subir Sheet")
                        showSheetComments.toggle()
                    }) {
                        Image(systemName: "message")
                            .foregroundStyle(Color.gray)
                    }
                    .sheet(isPresented: $showSheetComments) {
                        ScrollView {
                            CommentSheetView()
                                .presentationBackground(Color(hex: "212328"))
                        }
                        // Optional: Customize sheet behavior
                        .presentationDetents([.height(700), .large])
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

struct CommentSheetView: View {
    var body: some View {
        VStack {
            Text("Comments")
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 20)
            ForEach (0...50) { _ in
                CommentView()
            }
            Spacer()
        }
    }
}

struct InfosSheetView: View {
    var body: some View {
        VStack {
            Text("This is your sheet content!")
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}

struct CommentView: View{
    @State var isLiked = false
    @State var likeCount = 0
    
    var body: some View {
        HStack {
            Image("TomYorke")
                .resizable()
                .scaledToFit()  // Or .scaledToFit()
                .frame(width: 40, height: 40)  // Set desired frame size
                .clipShape(Circle())
            VStack (alignment: .leading) {
                HStack {
                    Text("profile")
                        .font(.caption)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                Text("Comentario")
                    .foregroundColor(.white)
                    .font(.caption)
            }
            Spacer()
            Button(action: {
                if !isLiked {
                    likeCount += 1
                } else if isLiked {
                    likeCount -= 1
                }
                isLiked.toggle()
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundStyle(
                        isLiked ? Color(hex: "FA1980") : Color.gray)
            }
        }
        .padding()
    }
}

#Preview {
    PostFeed(
        profileImage: "Radioheadthebends", profileName: "@TomYorke",
        postImage: "TomYorke", hour: Date.now, date: Date.now)
}
