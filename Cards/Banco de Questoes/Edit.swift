//
//  Edit.swift
//  Cards
//
//  Created by Felipe Camara on 26/02/22.
//

import SwiftUI

struct Edit: View {
    
    //State vars para os campos na tela de ediçao
    
    @State var pergunta: String = ""
    @State var a: String = ""
    @State var b: String = ""
    @State var c: String = ""
    @State var d: String = ""
    @State var index = ""
    @State var ref = ""
    @State var indexTema = ""
    @State var correçaoIndex = false
    
    //State vars para definir qual tela será projetada
    
    @State var edit = false
    @State var folder = true
    
    //State var para definir qual pasta o usuário abriu
    
    @State var temaSelecionado = ""
    
    //State var para armazenar os dados da questao seleecionada pelo usuário
    
    @State var inEdit = Alternativas()
    
    //Arrays para definir os itens que serao projetados nas listas
    
    @State private var data: [Alternativas] = [Alternativas]()
    @State private var arrayTemaSelecionado: [Alternativas] = [Alternativas]()
    @State private var arrayAllThemes: [Alternativas] = [Alternativas]()
    @State var allThemes = [String()]
    
    //func para atualizar a variável "data" e assim atualizar o View com o banco de dados atualizado
    
    private func populateQuestions() {
        data = []
        data = QuestionsCDManager.shared.getArrayOfQuestions()
    }
    
    //func para atualizar a variável "allThemes" e assim atualizar o View com o banco de dados atualizado
    
    private func populateThemes() {
        data = QuestionsCDManager.shared.getArrayOfQuestions()
        allThemes = []
        for dado in data {
            if dado.tema != "" {
                if !allThemes.contains(dado.tema!) {
                    allThemes.append(dado.tema!)
            }
        }
        }
    }
    
    //func para atualizar a variável "arrayTemaSelecionado" e assim atualizar o View com o banco de dados atualizado
    
    private func populateArrayTemaSelecionado() {
        data = QuestionsCDManager.shared.getArrayOfQuestions()
        arrayTemaSelecionado = []
        for dado in data {
            if dado != Alternativas() && !arrayTemaSelecionado.contains(dado) && dado.tema == temaSelecionado {
                arrayTemaSelecionado.append(dado)
            }
        }
    }
    
    private func storeInEdit(pergunta: String, a: String, b: String, c: String, d: String, certa: String,ref: String, tema: String) {
        
        inEdit.pergunta = pergunta
        inEdit.a = a
        inEdit.b = b
        inEdit.c = c
        inEdit.d = d
        inEdit.ref = ref
        inEdit.certa = certa
        inEdit.tema = tema
        
    }
    
    var body: some View {
        
        //A página Edit é composta por 3 páginas filhas: Folders, Questions e Edition.
        //Condicional para definir a primeira pagina a ser projetada
        
        if folder == true && edit == false {
            
            //Página Folders
            //OnAppear: Atualiza as váriaveis "data" e "allThemes".
            //Assim que as variáveis sao atualizadas, gera uma lista com base na variável allThemes.
            
            if #available(iOS 14.0, *) {
        
        GroupBox {
            
            VStack(alignment: .center, spacing: 20){
                Spacer()
                Text("Subjects:")
                    .font(.system(size: 30, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                
                let sortedThemes = allThemes.sorted(by: { $0 < $1 })
                
                List{
                    ForEach(sortedThemes, id: \.self) { question in //para cada tema em allThemes...
                        if question != ""{ //... se o tema for diferente de "", criar um botao com o nome do tema
                        HStack{
                            Image(systemName: "folder")
                            Button(question) {
                                temaSelecionado = question //...ao ser acionado, o botao define que o tema selecionado pelo usuário foi o correspondente do botao
                                populateArrayTemaSelecionado() //...gera uma array com todas as perguntas que possuem o tema selecionado
                                folder = false //fecha a página Folders e, consequentemente, abre a página Questions
                            }.foregroundColor(Color.black)
                        }
                            
                        }
                    }
                }
            }.frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 150, alignment: .center)
                .background(Color(.gray))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            	//OnAppear: Atualiza as "váriaveis" data e "allThemes".
                .onAppear(perform: {
                    populateQuestions()
                    populateThemes()
                })
            
        }
                
            } else {
                //falls back to previous version
            }
            
        } else {
            
            if folder == false && edit == false {
                
                //Página Questions
                //Gera uma lista com todas as perguntas que possuem o tema selecionado pelo usuário na página Folders
                
                if #available(iOS 14.0, *) {
                
                GroupBox {
                    
                    VStack(alignment: .center, spacing: 20){
                        Spacer()
                        Text(temaSelecionado)
                            .font(.system(size: 30, weight: .heavy, design: .monospaced))
                            .foregroundColor(Color(hue: 0.583, saturation: 0.248, brightness: 1.0))
                        
                        let sortedQuestions = arrayTemaSelecionado.sorted(by: { $0.pergunta! < $1.pergunta! })
                    
                    List{
                        ForEach(sortedQuestions,id: \.self) { question in //A lista usa como base a Array "arrayTemaSelecionado" que foi atualizada pelo botao na página Folders, portanto, nao precisa ser atualizada novamente
                            
                            Button(question.pergunta!) { //Para cada questao na Array, é gerado um botao com o texto da pergunta
                                
                                //Armazena os dados da questao nos State vars que serao usados para preencher o campo na página Edition
                                pergunta = question.pergunta!
                                a = question.a!
                                b = question.b!
                                c = question.c!
                                d = question.d!
                                ref = question.ref!
                                index = question.certa!
                                indexTema = question.tema!
                                
                                //storeInEdit(pergunta: question.pergunta!, a: question.a!, b: question.b!, c: question.c!, d: question.d!, certa: question.certa!, ref: question.ref!, tema: question.tema!)
                                 
                                edit = true //Fecha a tela Questions e, consequentente, abre a tela Edition
                                
                            }
                        }
                        //Código para permitir apagar uma questao na página Questions
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let dado = sortedQuestions[index] //usa a ordem da lista apresentada para o usuário na View
                                QuestionsCDManager.shared.deleteQuestion(pergunta: dado)
                                populateArrayTemaSelecionado() //atualiza a página que está aberta para o usuário
                            }
                        })
                            .foregroundColor(Color.black)
                        
                        HStack{
                            Image(systemName: "folder")
                            Button("...") {
                                folder = true
                                populateArrayTemaSelecionado()
                            }
                        }
                        
                    }
                }
                .frame(width: 350, height: 600, alignment: .center)
                .background(Color(.gray))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
                } else {
                    //falls back to previous version
                }
                    
                
            } else {
                
                //Página Edition
                //onAppear: Armazena as informaçoes originais da questao em uma constante "inEdit"
                //Usa das State vars para preencher os campos da página.
                
                
                if #available(iOS 14.0, *) {
                    Section{
                        Form{
                            VStack(alignment: .leading, spacing:30){
                                TextField("Type a Question", text: $pergunta)
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
                            if correçaoIndex == true {
                                Text("Fill the Question Field.").foregroundColor(Color.red)
                            }
                            
                            Section{
                                HStack(alignment: .center){
                                    Spacer()
                                Button("Back") { //Retorna a página Questions
                                    
                                    edit = false
                                    folder = false
                                    
                                }
                                    Spacer()
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
                    .onAppear(perform: {
                        
                        // Identifica a pergunta que está sendo editada e armazena eem "inEdit"
                        let db = QuestionsCDManager.shared.getArrayOfQuestions()
                        for question in db {
                            if question.pergunta == pergunta {
                                inEdit = question
                            }
                        }
                        
                    })
                    .navigationTitle("Create a Question")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button("Save", action: {
                        if pergunta == "" {
                            correçaoIndex = true
                        }
                        
                        if pergunta != "" && index != "" {
                        
                        QuestionsCDManager.shared.deleteQuestion(pergunta: inEdit) //deleta a questao original
                        QuestionsCDManager.shared.saveQuestion(pergunta: pergunta, a: a, b: b, c: c, d: d, certa: index,ref: ref, tema: indexTema) //Salva a nova alterada
                        populateArrayTemaSelecionado()
                            correçaoIndex = false
                        
                        //fecha a tela Edition e abre a tela Quetions
                        edit = false
                        folder = false
                            
                        }
                        
                    }
                                                        ))
                } else {
                    // Fallback on earlier versions
                }
            }
            }
            }
        }


struct Edit_Previews: PreviewProvider {
    static var previews: some View {
        Edit()
    }
}
