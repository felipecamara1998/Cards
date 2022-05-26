//
//  QuestionsCDManager.swift
//  Cards
//
//  Created by Felipe Camara on 19/10/21.
//

import Foundation
import CoreData

class QuestionsCDManager {
    
    //singleton
    
    static let shared = QuestionsCDManager()
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Questions")
        persistentContainer.loadPersistentStores { (description,error) in
            if let error = error {
                fatalError("CoreData Store Failed \(error.localizedDescription)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func getArrayOfQuestions() -> [Alternativas]{
        
        let fetchRequest: NSFetchRequest<Alternativas> = Alternativas.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteQuestion (pergunta: Alternativas) {
        
        viewContext.delete(pergunta)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
        
    }
    
    func start() -> Bool {
        
        let fetchRequest: NSFetchRequest<Alternativas> = Alternativas.fetchRequest()
        var teste: [Alternativas]
        
        do {
            teste = try viewContext.fetch(fetchRequest)
        } catch {
            teste = []
        }
        
        if teste == [] {
            return false
        } else {
            return true
        }
        
    }
    
    func organizeQuestionsPerLevel() -> [[Alternativas]] {
        
        let fetchRequest: NSFetchRequest<Alternativas> = Alternativas.fetchRequest()
        var muitoFacil: [Alternativas] = []
        var facil: [Alternativas] = []
        var mediana: [Alternativas] = []
        var dificil: [Alternativas] = []
        var questions: [Alternativas]? = []
        
        do {
            let questoes = try viewContext.fetch(fetchRequest)
            questions = questoes
            if questions == [] {
                questions = nil
            }
            
            for item in questoes {
                switch (Double(item.acertos) / Double(item.tentativas)) * 100 {
                case 0...30:
                    dificil.append(item)
                case 30...50:
                    mediana.append(item)
                case 50...80:
                    facil.append(item)
                case 80...100:
                    muitoFacil.append(item)
                default:
                    mediana.append(item)
            }
            }
            
        } catch {
            print("failed")
        }
        
        return [muitoFacil,facil,mediana,dificil]
    }
    
    func randomPickQuestion() -> Alternativas? {
        
        let fetchRequest: NSFetchRequest<Alternativas> = Alternativas.fetchRequest()
        var numero: ClosedRange<Int> = 0...1
        var muitoFacil: [Alternativas] = []
        var facil: [Alternativas] = []
        var mediana: [Alternativas] = []
        var dificil: [Alternativas] = []
        var questions: [Alternativas]? = []
        
        do {
            let questoes = try viewContext.fetch(fetchRequest)
            questions = questoes
            if questions == [] {
                questions = nil
            }
            
            for item in questoes {
                switch (Double(item.acertos) / Double(item.tentativas)) * 100 {
                case 0...30:
                    dificil.append(item)
                case 30...50:
                    mediana.append(item)
                case 50...80:
                    facil.append(item)
                case 80...100:
                    muitoFacil.append(item)
                default:
                    mediana.append(item)
            }
            }
            
        } catch {
            print("failed")
        }
        
        let array = [0...100]
        numero = array.randomElement()!
        
            switch numero {
            
            case 0...30:
                return dificil.randomElement()
            case 30...50:
                return mediana.randomElement()
            case 50...80:
                return facil.randomElement()
            case 80...100:
                return muitoFacil.randomElement()
            default:
                return questions!.randomElement() ?? nil
                
            
            }
        
    }
    
    func atualizarEstatisticas(correçao: Bool, questao: Alternativas) {
        if correçao == true {
        questao.acertos = questao.acertos + 1
        }
        questao.tentativas = questao.tentativas + 1
        
        do {
            try viewContext.save()
        } catch {
            print("failed to save")
        }
    }
    
    func saveQuestion(pergunta: String, a: String?, b: String?, c: String?, d: String?, certa: String, ref: String?, tema: String?) {
        let question = Alternativas(context: viewContext)
        
        if a == nil {
            question.a = "-"
        } else {
            question.a = a
        }
        
        if b == nil {
            question.b = "-"
        } else {
            question.b = b
        }
        
        if c == nil {
            question.c = "-"
        } else {
            question.c = c
        }
        
        if d == nil {
            question.d = "-"
        } else {
            question.d = d
        }
        
        question.certa = certa
        question.pergunta = pergunta
        question.tema = tema
        question.acertos = 0
        question.tentativas = 0
        if ref == "" {
            question.ref = "No References"
        } else {
        question.ref = ref
        }
        if tema == "" {
        question.tema = "Default"
        } else {
            question.tema = tema
        }
        
        
        do {
            try viewContext.save()
        } catch {
            print("failed to save")
        }
        
        
    }
    
    func saveQuestion3(pergunta: String, a: String, b: String, c: String, d: String, certa: String, ref: String?, tema: String?) {
        let question = Alternativas(context: viewContext)
        
        question.a = a
        question.b = b
        question.c = c
        question.d = d
        question.certa = certa
        question.pergunta = pergunta
        question.tema = tema
        question.acertos = 0
        question.tentativas = 0
        if ref == nil {
            question.ref = "No References"
        } else {
        question.ref = ref
        }
        if tema == nil {
        question.tema = "Default"
        } else {
            question.tema = tema
        }
        
        
        do {
            try viewContext.save()
        } catch {
            print("failed to save")
        }
        
        
    }
    
    func saveQuestion2(pergunta: String, a: String, b: String, c: String, d: String, certa: String, acertos: String, tentativas: String, ref: String?, tema: String?) {
        let question = Alternativas(context: persistentContainer.viewContext)
        
        question.a = a
        question.b = b
        question.c = c
        question.d = d
        question.certa = certa
        question.pergunta = pergunta
        question.tema = tema
        question.acertos = Double(acertos) ?? 0
        question.tentativas = Double(tentativas) ?? 0
        question.ref = ref
        question.tema = tema
        
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("failed to save")
        }
        
        
    }
}
