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
    @State private var ano = Date()
    @State private var tags: [String] = []
    @State private var categ: Category? = nil

    var body: some View {
        VStack {
            TextField("Título", text: $titulo)
                .textFieldStyle(.plain)
                .padding(10)
                .border(Color.black, width: 0.5)
                .background(Color(UIColor.secondarySystemBackground))

            TextField("Descrição", text: $desc, axis: Axis.vertical)
                .textFieldStyle(.plain)
                .padding(10)
                .border(Color.black, width: 0.5)
                .background(Color(UIColor.secondarySystemBackground))

            TextField("Autor", text: $autor)
                .textFieldStyle(.plain)
                .padding(10)
                .border(Color.black, width: 0.5)
                .background(Color(UIColor.secondarySystemBackground))

            HStack {
                Text("Ano")
                Picker("", selection: $ano) {
                    ForEach(2000...2025, id: \.self) {
                        Text(String($0))
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    UploadView()
}
