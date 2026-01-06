//
//  UploadView.swift
//  TellMeProject
//
//  Created by found on 05/12/25.
//

import SwiftUI
import SwiftUIExtras

enum Category {
    case pintura, fotografia, texto, poema, musica, escultura, video
};

struct UploadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var titulo: String = ""
    @State private var desc: String = ""
    @State private var autor: String = ""
    @State private var ano: Int = 0
    @State private var tags: [String] = []
    @State private var categ: Category? = nil

    var body: some View {
        VStack {
            TextFieldStack(label: "Título", text: $titulo)

            TextFieldStack(label: "Descrição", text: $desc)

            TextFieldStack(label: "Autor", text: $autor)

            TextFieldStack(label: "Ano", value: $ano)
        }
        .padding()
    }
}

#Preview {
    UploadView()
}
