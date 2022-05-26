//
//  Home.swift
//  Cards
//
//  Created by Felipe Camara on 03/03/22.
//

import SwiftUI

struct Home: View {

    @State var start = false
    @State var ad = false
    
    var body: some View {
        
        let coreDM = QuestionsCDManager()
        
        if start == true {
            
            ZStack {
        
        NavigationView{
            
            Form {
                Section{
                    
                    HStack(alignment: .center, spacing:5){
                        Spacer()
                        Image(uiImage: UIImage(named: "180x180")!)
                        .scaledToFit()
                        .frame(width: 130, height: 100, alignment: .center)
                        Text("Cards")
                            .fontWeight(.light)
                            .lineLimit(1)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.system(size: 50, weight: .light, design: .serif))
                            .foregroundColor(Color(hue: 0.571, saturation: 0.523, brightness: 0.901))
                            .frame(width: 130, height: 100, alignment: .center)
                            .scaledToFit()
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
                    .scaleEffect(0.5)
                    
                    
                    
                    NavigationLink("Classic", destination: CardsAlternativas(coreDM: QuestionsCDManager.shared))
                    //NavigationLink("Simulado", destination: CriarQuestoes())
                    //NavigationLink("Estatísticas", destination: Estatisticas(coreDM: QuestionsCDManager()))
                    NavigationLink("Create a Question", destination: CriarAlternativas())
                    NavigationLink("Edit/Delete", destination: Edit())
                    //NavigationLink("Data", destination: BancoDeQuestoes(coreDM: QuestionsCDManager()))
                    //NavigationLink("Importar/Exportar Banco de Dados", destination: TextFileManager(coreDM: QuestionsCDManager()))
                    NavigationLink("Import/Export Data", destination: ImportExport(coreDM: QuestionsCDManager.shared).onAppear(perform: {ad = false}))
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                start = coreDM.start()
                ad = false
            })
        }
        .navigationViewStyle(.stack)
        .ignoresSafeArea(.all)
                
                if ad == true {
                VStack{
                Spacer()
                Banner(unitID: "ca-app-pub-2380645200806782/8108513556")
                    .frame(width: 320, height: 50, alignment: .center)
                    .offset(x: 0, y: -10)
                }
                }
                
            }
            
            
            
            
            
        } else {
            
            ZStack {
            NavigationView{
                Form {
                    Section{
                        
                        HStack(alignment: .center, spacing:5){
                            Spacer()
                            Image(uiImage: UIImage(named: "180x180")!)
                            .scaledToFit()
                            .frame(width: 130, height: 100, alignment: .center)
                            Text("Cards")
                                .fontWeight(.light)
                                .lineLimit(1)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.system(size: 50, weight: .light, design: .serif))
                                .foregroundColor(Color(hue: 0.571, saturation: 0.523, brightness: 0.901))
                                .frame(width: 130, height: 100, alignment: .center)
                                .scaledToFit()
                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.1, alignment: .leading)
                        .scaleEffect(0.5)
                        
                        //NavigationLink("Clássico", destination: CardsAlternativas(coreDM: QuestionsCDManager()))
                        //NavigationLink("Simulado", destination: CriarQuestoes())
                        //NavigationLink("Estatísticas", destination: Estatisticas(coreDM: QuestionsCDManager()))
                            NavigationLink("Create a Question", destination: CriarAlternativas())
                        	Text("Empty DataBase").foregroundColor(Color.gray)
                        	NavigationLink("Import/Export Data", destination: ImportExport(coreDM: QuestionsCDManager.shared))
                    }
                }
                .navigationTitle("Start creating a question")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear(perform: {
                    start = coreDM.start()
                    ad = false
                })
            }
            .navigationViewStyle(.stack)
            .onAppear(perform: {
                start = QuestionsCDManager.shared.start()
            })
            .ignoresSafeArea(.all)
            
                VStack{
                Spacer()
                Banner(unitID: "ca-app-pub-2380645200806782/8108513556")
                    .frame(width: 320, height: 50, alignment: .center)
                    .offset(x: 0, y: -10)
                }
                
            }
        }
    }
    }
