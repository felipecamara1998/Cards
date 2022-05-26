//
//  MessageDocument.swift
//  Cards
//
//  Created by Felipe Camara on 05/11/21.
//

import SwiftUI
import UniformTypeIdentifiers

//func saveQuestion(pergunta: String, a: String, b: String, c: String, d: String, certa: String, ref: String?, tema: String?)

struct MessageDocument: FileDocument {
    
    @available(iOS 14.0, *)
    static var readableContentTypes: [UTType] { [.plainText] }

    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf32)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf32)!)
    }
    
}
