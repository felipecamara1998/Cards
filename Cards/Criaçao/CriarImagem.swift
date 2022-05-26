//
//  CriarImagem.swift
//  Cards
//
//  Created by Felipe Camara on 19/10/21.
//

import SwiftUI

struct CriarImagem: View {
    
    @State var text: String = ""
    var resposta: String?
    
    var body: some View {
        Section {
            VStack(alignment: .center, spacing:30){
            Text("Como se chama a imagem abaixo?")
                .padding()
                .scaledToFill()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .background(Color(.cyan))
            Image(systemName: "heart")
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .scaledToFill()
            TextField("Resposta", text: $text)
            Text("Responder")
                .padding()
                .background(Color(.gray))
        }
        .padding()
        .background(Color(.white))
        .scaledToFit()
        }
    }
}

struct CriarImagem_Previews: PreviewProvider {
    static var previews: some View {
        CriarImagem()
    }
}
