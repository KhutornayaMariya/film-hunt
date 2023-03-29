//
//  Decryptor.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import Foundation

final class Decryptor {
    
    func getString(from bytes: [UInt8]) -> String {
        String(bytes: bytes, encoding: .utf8) ?? ""
    }
}
