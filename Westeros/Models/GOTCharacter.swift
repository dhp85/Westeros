//
//  GotCharacter.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 10/9/24.
//

import Foundation

struct GOTCharacter: Codable, Hashable {
    let fullName: String
    let title: String
    let family: String
}

/*
 {
     "fullName": "Jon Snow",
     "title": "Test"
     "family": "House Stark"
 
 }
 */

// Este es un ejemplo de como usar Coding Keys

struct CustomCodableCharacter: Codable {
    let nombreCompleto: String
    let titulo: String
    let familia: String
    
}

extension CustomCodableCharacter {
    enum CodingKeys: String, CodingKey {
        case nombreCompleto = "fullName"
        case titulo = "title"
        case familia = "family"
    }
}
