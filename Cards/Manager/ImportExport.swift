//
//  SwiftUIView.swift
//  Cards
//
//  Created by Felipe Camara on 05/11/21.
//

import SwiftUI

func converterQuestaoToString(array: [Alternativas]) -> String {
    
    var data: String = ""
    
    for elemento in array {
        data.append(elemento.pergunta!)
        data.append(";")
        data.append(elemento.a!)
        data.append(";")
        data.append(elemento.b!)
        data.append(";")
        data.append(elemento.c!)
        data.append(";")
        data.append(elemento.d!)
        data.append(";")
        data.append(elemento.certa ?? "")
        data.append(";")
        data.append(String(elemento.acertos))
        data.append(";")
        data.append(String(elemento.tentativas))
        data.append(";")
        data.append(elemento.tema!)
        data.append(";")
        data.append(elemento.ref!)
        data.append("\n")
    }
    
    return data
    
}

func converterStringToQuestao(data: String) -> [[String]] {
    
    let lineSeparator = data.components(separatedBy: "\n")
    var arrayAlternativas: [[String]] = []
    
    for line in lineSeparator {
        let itemSeparator = line.components(separatedBy: ";")
        arrayAlternativas.append(itemSeparator)
    }
    
    return arrayAlternativas
    
}

func atualizar (texto: String) -> MessageDocument {
    return MessageDocument(message: texto)
}

struct ImportExport: View {
    
    var coreDM: QuestionsCDManager
    
    @State var test = MessageDocument(message: "")
    @State private var document = MessageDocument(message: "")
    @State private var isImporting: Bool = false
    @State private var isExporting: Bool = false
    @State private var fileName: String = ""
    @State var selectFolderScreen = false
    @State var blur = 0
    
    var body: some View {

        VStack {
            GroupBox(label: Text("Data File:")) {
                TextEditor(text: $test.message)
                /*Button("Select Subjects") {
                    selectFolderScreen = true
                }*/
                TextField("File Name", text: $fileName)
            }
            GroupBox {
                HStack {
                    Spacer()
                    
                    Button(action: { isImporting = true }, label: {
                        Text("Import")
                    })
                    
                    Spacer()
                    
                    Button(action: { isExporting = true }, label: {
                        Text("Export")
                    })
                    
                    Spacer()
                }
            }
        }
        .padding()
        .onAppear(perform: {
            let coreDM1 = QuestionsCDManager().getArrayOfQuestions()
            test = atualizar(texto: converterQuestaoToString(array: coreDM1))
        })
        .fileExporter(
              isPresented: $isExporting,
              document: test,
              contentType: .plainText,
              defaultFilename: fileName
          ) { result in
              if case .success = result {
                  
              } else {
                  
              }
          }
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [.plainText],
            allowsMultipleSelection: false
        ) { result in
            do {
                guard let selectedFile: URL = try result.get().first else { return }
                if selectedFile.startAccessingSecurityScopedResource() {
                                    guard let input = String(data: try Data(contentsOf: selectedFile), encoding: .utf32) else { return }
                                    defer { selectedFile.stopAccessingSecurityScopedResource() }
                    document.message = input
                    let toSave = converterStringToQuestao(data: input)
                    for item in toSave {
                        
                        if item.count != 10{
                            continue
                        } else {
                            var index = 0
                            for pergunta in coreDM.getArrayOfQuestions() {
                                if item[0] == pergunta.pergunta {
                                    index = 1
                                         }
                            }
                            if index == 0 {
                                    coreDM.saveQuestion2(pergunta: item[0], a: item[1], b: item[2], c: item[3], d: item[4], certa: item[5], acertos: item[6], tentativas: item[7], ref: item[9], tema: item[8])
                                
                            }
                        }
                        
                    }
                    test.message = converterQuestaoToString(array: coreDM.getArrayOfQuestions())
                    
                                } else {
                                    // Handle denied access
                                }
                
            } catch {
            }
            }
        }
        }

/*struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(
            effect: UIBlurEffect(style: style)
        )
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //
    }
    
}*/

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImportExport(coreDM: QuestionsCDManager())
    }
}
