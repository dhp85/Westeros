//
//  NetworkModel.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 18/9/24.
//

import Foundation


final class NetworkModel {
    // Estamos creando el NetworkModel como singleton.
    static let share = NetworkModel()
    
    //  https://thronesapi.com
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "thronesapi.com"
        return components
    }
    
    private let client: APIClientProtocol
    
    private init(client: APIClientProtocol = APIClient()) {
        self.client = client
        
    }
    
    func getAllCharacters(completion: @escaping (Result<[GotCharacter], WesterosError>) -> Void) {
        // Vamos a crear nuestra url request.
        var components = baseComponents
        components.path = "/api/v2/Characters"
        
        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "Get"
        
        client.requestCharacters(urlRequest, completion: completion)
        
    }
    
    // Creado al principio de la clase.
    /*func get1AllCharacters(completion: @escaping ([GotCharacter]?, Error?) -> Void) {
     // Vamos a crear nuestra url request.
     var components = baseComponents
     components.path = "/api/v2/Characters"
     
     guard let url = components.url else {
     return
     }
     
     var urlRequest = URLRequest(url: url)
     urlRequest.httpMethod = "Get"
     
     //client.requestCharacters(urlRequest, completion: completion)
     }
     }*/
}
