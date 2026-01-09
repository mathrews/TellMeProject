//
//  MyComponent.swift
//  TellMeProject
//
//  Created by found on 12/12/25.
//

import SwiftUI

struct TextFieldStack: View {
    var label: String
    var text: Binding<String>?
    var value: Binding<Int>?

    var body: some View {
        if let text = text {
            ZStack {
                Rectangle().fill(Color(UIColor.white))

                HStack {
                    Text(label)
                    TextField("", text: text)
                        .textFieldStyle(.plain)
                        .padding(10)
                        .border(Color.black, width: 0.5)
                        .background(Color(UIColor.secondarySystemBackground))
                }
            }

        } else if let value = value {
            HStack{
                Text(label)
                TextField("", value: value, formatter: NumberFormatter())
                    .textFieldStyle(.plain)
                    .padding(10)
                    .border(Color.black, width: 0.5)
                    .background(Color(UIColor.secondarySystemBackground))
            }
        }
    }
}
#Preview {
    UploadView()
}
