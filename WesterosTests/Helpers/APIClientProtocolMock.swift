//
//  APIClientProtocolMock.swift
//  WesterosTests
//
//  Created by Diego Herreros Parron on 19/9/24.
//

import Foundation
@testable import Westeros

// Necesitamos definir un generico con la misma restriccion que T
// Para poder enviar valores al completion handler
final class APIClientProtocolMock<C: Codable>: APIClientProtocol {
    var session: URLSession = .shared
    
    var didCallRequest = false
    var receivedRequest: URLRequest?
    // Este generico C tiene la misma restriccion `Codable` que T
    var receivedResult: Result<C, WesterosError>?
    func request<T: Codable>(
        _ type: T.Type,
        from request: URLRequest,
        completion: @escaping (Result<T, Westeros.WesterosError>) -> Void
    ) {
        receivedRequest = request
        didCallRequest = true
        
        if let result = receivedResult as? Result<T, WesterosError> {
            completion(result)
        }
    }
}

