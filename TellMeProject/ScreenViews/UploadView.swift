//
//  UploadView.swift
//  TellMeProject
//
//  Created by found on 05/12/25.
//

import SwiftUI
import SwiftUIExtras
import PhotosUI

enum Category {
    case pintura, fotografia, texto, poema, musica, escultura, video
};

enum Categorias: String, CaseIterable, Identifiable {
    case pintura = "Pintura"
    case fotografia = "Fotografia"
    case texto_prosa = "Texto em prosa"
    case poema = "Poema"
    case musica = "Música"
    case escultura = "Escultura"
    case filme_video = "Filme ou Vídeo"
    case outro = "Outro"

    var id: Self { self.self }
}

enum AnoKinds: String, CaseIterable, Identifiable {
    case AC = "a.C."
    case DC = "d.C."
    case indefinido = "Indefinido"

    var id: Self { self.self }
}

enum UploadKinds: String, CaseIterable, Identifiable {
    case imagem = "Upload de imagem"
    case video = "Upload de vídeo"
    case audio = "Upload de audio"
    case texto = "Upload de texto"
    case _undefined = "Undefined"

    var id: Self { self.self }
}

struct Ano {
    var tipo: AnoKinds = .indefinido
    var ano: Int? = nil
}

struct UploadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var titulo: String = ""
    @State private var desc: String = ""
    @State private var autor: String = ""
    @State private var ano: Ano = Ano(tipo: .DC, ano: Calendar.current.component(.year, from: Date()))
    @State private var tags: [String] = []
    @State private var categ: Categorias? = nil
    @State private var uploadType: UploadKinds? = nil
    @State private var uploadTexto: String = ""
    @State private var selectedImgVid: PhotosPickerItem? = nil
    @State private var imgData: Data?
    @State private var vidURL: URL?

//    @State private var uploadArquvo: File = nil temporario

    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section(header: Text("Título")){
                        TextField("", text: $titulo)
                            .padding(.leading)
                    }

                    Section(header: Text("Descrição")) {
                        TextEditor(text: $desc)
                            .frame(minHeight: 200)
                    }

                    Section(header: Text("Autor")) {
                        TextField("", text: $autor)
                            .padding(.leading)
                    }

                    Section(header: Text("Ano")) {
                        if (ano.tipo != .indefinido) {
                            TextField("", value: $ano.ano, formatter: NumberFormatter())
                                .onChange(of: ano.ano) {
                                    if let tmp = ano.ano, tmp <= 0 {
                                        ano.ano = nil
                                    }
                                }
                                .onChange(of: ano.tipo) {
                                        ano.ano = nil
                                }
                        }

                        Picker("", selection: $ano.tipo) {
                            ForEach(AnoKinds.allCases, id: \.self) { tipo in
                                Text(tipo.rawValue).tag(tipo)
                            }
                        }.labelsHidden()
                    }

                    Section(header: Text("Categoria")) {
                        Picker("", selection: $categ) {
                            ForEach(Categorias.allCases, id: \.self) { tipo in
                                Text(tipo.rawValue).tag(tipo)
                            }
                        }
                        .labelsHidden()
                        .onChange(of: categ) {
                            switch (categ) {
                            case .texto_prosa, .poema:
                                uploadType = .texto
                            case .musica:
                                uploadType = .audio
                            case .fotografia:
                                uploadType = .imagem
                            case .filme_video:
                                uploadType = .video
                            default:
                                uploadType = ._undefined
                            }
                        }

                        if uploadType == ._undefined {
                            // deixa o usuário decidir
                            Picker("", selection: $uploadType) {
                                ForEach(UploadKinds.allCases, id: \.self) { tipo in
                                    if tipo != ._undefined {
                                        Text(tipo.rawValue).tag(tipo)
                                    }
                                }
                            }.labelsHidden()
                       }

                    }

                    if uploadType != nil {
                        Section(header: Text("Upload")) {
                            if uploadType == .texto {
                                TextEditor(text: $uploadTexto)
                                    .frame(minHeight: 200)
                            } else {
                                PhotosPicker(
                                    selection: $selectedImgVid,
                                    matching: .any(of: [.images, .videos])
                                ) {
                                    Text("Selecionar imagem ou vídeo")
                                }
                                .task(id: selectedImgVid) {
                                    guard let item = selectedImgVid else { return }

                                    if item.supportedContentTypes.contains(.image) {
                                        imgData = try? await item.loadTransferable(type: Data.self)
                                        vidURL = nil
                                    } else if item.supportedContentTypes.contains(.movie) {
                                        imgData = nil
                                        vidURL = try? await item.loadTransferable(type: URL.self)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

/*
 import SwiftUI

 struct UploadView: View {
 @State private var titulo = "Noite Estrelada"
 @State private var descricao = """
 "Noite Estrelada" é uma pintura de 1889 do artista pós-impressionista holandês Vincent van Gogh, considerada uma de suas obras-primas...
 """

 var body: some View {
 NavigationStack {
 Form {
 // TÍTULO
 Section {
 HStack {
 Text("Título")
 .foregroundColor(.secondary)
 TextField("Digite o título", text: $titulo)
 .multilineTextAlignment(.trailing)
 }
 }

 // DESCRIÇÃO
 Section(header: Text("Descrição")) {
 TextEditor(text: $descricao)
 .frame(minHeight: 200)
 }
 }
 .navigationTitle("Upload")
 .navigationBarTitleDisplayMode(.inline)
 }
 }
 }
 */

#Preview {
    UploadView()
}
