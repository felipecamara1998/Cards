//
//  CriarAlternativas.swift
//  Cards
//
//  Created by Felipe Camara on 19/10/21.
//

import SwiftUI

struct CriarAlternativas: View {
    
    @State var pergunta: String = ""
    @State var a: String = ""
    @State var b: String = ""
    @State var c: String = ""
    @State var d: String = ""
    @State var index: String = ""
    @State var ref: String = ""
    @State var indexTema: String = ""
    @State private var data: [Alternativas] = [Alternativas]()
    @State var correçao = false
    @State var correçaoCerta = false
    
    private func populateNewQuestion() {
        data = []
        data = QuestionsCDManager.shared.getArrayOfQuestions()
    }
    
    var body: some View {
        if #available(iOS 14.0, *) {
            Section{
                Form{
                    VStack(alignment: .leading, spacing:30){
                        TextField("Question", text: $pergunta)
                            .padding()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color(.cyan))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        TextField("Alternative A", text: $a)
                        TextField("Alternative B", text: $b)
                        TextField("Alternative C", text: $c)
                        TextField("Alternative D", text: $d)
                    }
                    .padding()
                    .background(Color(.gray))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    Picker("Alternativa Correta", selection: $index, content: {
                        Text("A").tag("A")
                        Text("B").tag("B")
                        Text("C").tag("C")
                        Text("D").tag("D")
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("References", text: $ref)
                    TextField("Subject", text: $indexTema)
                    
                    
                    Section {
                        if correçao == true {
                        Text("Fill the Question Field.")
                            .foregroundColor(Color.red)
                    }
                    
                    if correçaoCerta == true {
                        Text("Select the correct answer for this question.")
                            .foregroundColor(Color.red)
                    }
                    }
                    //Picker("Tema", selection: $indexTema, content: {
                    //    let temas = temasDM.getArrayOfThemes()
                    //    TextField("Novo Tema", text: $indexTema)
                    //    ForEach(temas, id: \.self) { elemento in
                    //       Text(elemento.description).tag(elemento.description)
                    //     }
                    // }
                    //     )
                    
                }
            }
            .navigationTitle("Create a Question")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Save", action: {
                
                if pergunta == "" {
                    correçao = true
                } else {
                    correçao = false
                }
                
                if index == "" {
                    correçaoCerta = true
                } else {
                    correçaoCerta = false
                }
                
                if pergunta != "" && index != "" {
                
                QuestionsCDManager.shared.saveQuestion(pergunta: pergunta, a: a, b: b, c: c, d: d, certa: index,ref: ref, tema: indexTema)
                populateNewQuestion()
                pergunta = ""
                a = ""
                b = ""
                c = ""
                d = ""
                index = ""
                ref = ""
                indexTema = ""
                    
                }
            }))
        } else {
            // Fallback on earlier versions
        }
    }
    
}


struct CriarAlternativas_Previews: PreviewProvider {
    static var previews: some View {
        CriarAlternativas()
    }
}
