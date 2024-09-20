//
//  APIClientProtocolMock.swift
//  WesterosTests
//
//  Created by Diego Herreros Parron on 19/9/24.
//

import Foundation
// con @testable podemos acceder a todos las funcionalidades como si fueran public y no hay necesidad de ponerlas publicas a mano
@testable import Westeros

// el Mock es para inspeccionar propiedades y para enviar el resultado que queremos.
// Necesitamos definir un generico con la misma restriccion que T para poder enviar valores al completion handler.
final class APIClientProtocolMock<C: Codable>: APIClientProtocol {
    var session: URLSession = .shared
    
    //
    var didCallRequest = false
    
    var recivedRequest: URLRequest?
    // Este generioc C tiene la misma restriccion "Codable" que T.
    var recivedResult: Result<C, WesterosError>?
    
    func request<T>(_ type: T.Type, from request: URLRequest, completion: @escaping (Result<T, Westeros.WesterosError>) -> Void) where T : Decodable, T : Encodable {
        
        recivedRequest = request
        didCallRequest = true
        
        if let result = recivedResult as? Result<T,WesterosError> {
            completion(result)
        }
        
    }
    
    
    
}

// MARK: SPY
//esto seria el concepto de spy, saber si estoy llamando al request

/*final class APIClientProtocolMock: APIClientProtocol {
    var session: URLSession = .shared
    
    // saber si llama a request
    var didCallRequest = false
    // testea la url que le llega
    var recivedRequest: URLRequest?
    
    func request<T>(_ type: T.Type, from request: URLRequest, completion: @escaping (Result<T, Westeros.WesterosError>) -> Void) where T : Decodable, T : Encodable {
        
        recivedRequest = request
        didCallRequest = true
    }
    
    
    
}*/
