//
//  NetworkModel.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 18/9/24.
//

import Foundation

final class NetworkModel {
    // Estamos creando el NetworkModel como singleton
    static let shared = NetworkModel()
    
    // https://thronesapi.com
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thronesapi.com"
        return components
    }
    
    private let client: APIClientProtocol
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func getAllCharacters(
        completion: @escaping (Result<[GOTCharacter], WesterosError>) -> Void
    ) {
        // Vamos a crear nuestra url request
        var components = baseComponents
        components.path = "/api/v2/Characters"
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        client.request([GOTCharacter].self, from: urlRequest, completion: completion)
    }
    
    func getAllCharacters(
        completion: @escaping ([GOTCharacter]?, Error?) -> Void
    ) {
        // Vamos a crear nuestra url request
        var components = baseComponents
        components.path = "/api/v2/Characters"
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
//        client.requestCharacters(urlRequest, completion: completion)
    }
}
