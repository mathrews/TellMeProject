//
//  PostFeed.swift
//  TellMeProject
//
//  Created by found on 09/12/25.
//

import SwiftUI
import SwiftUIExtras

// Este struct guarda os dados reais (texto, curtida, contagem).
// Ele é Identifiable para funcionar com ForEach sem precisar de índices.
struct Comment: Identifiable {
    let id = UUID()
    var text: String
    var isLiked: Bool
    var likeCount: Int
}

struct PostFeed: View {
    var profileImage: String = "Radioheadthebends"
    var profileName: String = "@TomYorke"
    var postImage: String = "TomYorke"
    var hour: Date = Date.now
    var date: Date = Date.now

    
    // Array que guarda os comentários
    @State var comments: [Comment] = []
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
                        CommentSheetView(comments: $comments)
                            .presentationBackground(Color(hex: "212328"))
                            .presentationDetents([.height(700), .large]) // Optional: Customize sheet behavior
                            
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

// Sheet que mostra os comentários e permite adicionar novos
struct CommentSheetView: View {
    
    @Binding var comments: [Comment] 
    
    // Texto que o usuário digita
    @State var newCommentText: String = ""
    
    var body: some View {
        VStack {
            // Título da Sheet
            Text("Comentários")
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.bottom, 12)
            
            // Lista com scroll dos cometários existentes
            ScrollView {
                        LazyVStack(spacing: 12) {
                            // Para cada comentário nos dados, cria uma CommentView
                            ForEach(comments) { comment in
                                CommentView(comment: comment) {
                                    // Quando o usuário clica no coração, avisa esta view para atualizar os dados
                                    likeComment(withId: comment.id)
                                }
                            }
                        }
                        .padding(.horizontal)
            }
            
            // Barra de inserção de novo comentário
            HStack(spacing: 8) {
                // Campo de texto clean
                TextField("Adicione um comentário...", text: $newCommentText, axis: .vertical)
                    .lineLimit(1...3)
                    .padding(10)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .font(.body)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        postComment()
                    }

                // Botão "Post"
                if !newCommentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Button("Post") {
                        postComment()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Color(hex: "212328") // Mesma cor do fundo da sheet → funde perfeitamente
                    .ignoresSafeArea(.container, edges: .bottom)
            )
        }
    }
    
    // Função chamada quando o usuário clica no coração de um comentário
    func likeComment(withId id: UUID) {
        // Procura o comentário no array pelo ID
        guard let index = comments.firstIndex(where: { $0.id == id }) else { return }
        
        // Atualiza o estado real do comentário
        comments[index].isLiked.toggle()
        if comments[index].isLiked {
            comments[index].likeCount += 1
        } else {
            comments[index].likeCount = max(0, comments[index].likeCount - 1)
        }
        // O SwiftUI detecta a mudança e atualiza automaticamente a CommentView
    }

    // Função chamada ao pressionar "Post"
    func postComment() {
        let trimmed = newCommentText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Cria um novo comentário com dados reais
        let newComment = Comment(text: trimmed, isLiked: false, likeCount: 0)
        comments.insert(newComment, at: 0) // Insere no topo
        newCommentText = "" // Limpa o campo
    }
    
}

// Exibe dados e notifica quando há interação.
struct CommentView: View{
    
    let comment: Comment
    
    // Função a ser chamada quando o usuário curtir
    let onLike: () -> Void
    
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
                
                Text(comment.text)
                    .foregroundColor(.white)
                    .font(.caption)
            }
            Spacer()
            
            // Botão de curtida: chama onLike() quando pressionado
            Button(action: onLike) {
                Image(systemName: comment.isLiked ? "heart.fill" : "heart")
                    .foregroundStyle(comment.isLiked ? Color(hex: "FA1980") : .gray)
            }
        }
        .padding()
    }
}

// Sheet de informações (simples, só exemplo)
struct InfosSheetView: View {
    var body: some View {
        VStack {
            Text("This is your sheet content!")
                .font(.title)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    PostFeed(
        profileImage: "Radioheadthebends",
        profileName: "@TomYorke",
        postImage: "TomYorke",
        hour: Date.now,
        date: Date.now)
}
