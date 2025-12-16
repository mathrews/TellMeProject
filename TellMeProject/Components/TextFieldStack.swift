//
//  MyComponent.swift
//  TellMeProject
//
//  Created by found on 12/12/25.
//

import SwiftUI

struct MyComponent: View {
    var label: String
    var text: Binding<String>
    
    var body: some View {
        HStack{
            Text(label)
            TextField("", text: text)
                .textFieldStyle(.plain)
                .padding(10)
                .border(Color.black, width: 0.5)
                .background(Color(UIColor.secondarySystemBackground))
        }
        
    }
}
