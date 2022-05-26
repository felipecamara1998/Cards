//
//  CriarQuestoes.swift
//  Cards
//
//  Created by Felipe Camara on 19/10/21.
//

import SwiftUI

struct CriarQuestoes: View {
    var body: some View {
        Form{
                NavigationLink("Questao de alternativa", destination: CriarAlternativas())
                NavigationLink("Questao de Imagem", destination: CardsImagem())
                }
    }
            }

struct CriarQuestoes_Previews: PreviewProvider {
    static var previews: some View {
        CriarQuestoes()
    }
}
