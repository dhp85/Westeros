//
//  APIClient.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 18/9/24.
//

import Foundation

enum WesterosError: Error {
    case noData
    case decodingFailed
    case statusCode(code: Int?)
    case unknown
    
}



protocol APIClientProtocol {
    var session: URLSession { get }
    func requestCharacters(_ request: URLRequest, completion: @escaping (Result<[GotCharacter], WesterosError>) -> Void)
}

struct APIClient: APIClientProtocol {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requestCharacters(_ request: URLRequest, completion: @escaping (Result<[GotCharacter], WesterosError>) -> Void) {
        let task = session.dataTask(with: request) {data, response, error in
            let result: Result<[GotCharacter], WesterosError>
            
            defer {
                
                completion(result)
            }
            
            guard error == nil else {
                result = .failure(.unknown)
                return
            }
            
            guard let data else {
                result = .failure(.noData)
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            guard statusCode == 200 else {
                result = .failure(.statusCode(code: statusCode))
                return
            }
            
            guard let characters = try? JSONDecoder().decode([GotCharacter].self, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            
            result = .success(characters)
        }
        
        task.resume()
    }
    
    
    // Esta es la version antigua.
    /*func requestCharacters(_ request: URLRequest, completion: @escaping ([GotCharacter]?, Error?) -> Void) {
     
     let task = session.dataTask(with: request) { data, response, error in
     // Compruebo si obtengo un error
     guard error == nil else {
     // Si lo obtengo lo envio por el completion handler
     completion(nil, error)
     return
     }
     
     guard let data else {
     return
     }
     
     // Obtengo un codigo de estado de la respuesta del servidor.
     let statusCode = (response as? HTTPURLResponse)?.statusCode
     
     // Compruebo si el codigo de estado es 200.
     // Tendriamos que ver la documentacion de la API que estamos usando
     // Para comprobar los codigos de estado
     
     guard statusCode == 200 else {
     return
     }
     
     // Intentar decodificar un array de GOTCharacter a traves del objeto data.
     // Este objeto data generalmente es el Body de la respuesta del servidor.
     guard let characters = try? JSONDecoder().decode([GotCharacter].self, from: data) else {
     return
     }
     
     // Si pudimos decodificar el array de GOTCharacter, llamamos al completion handler.
     completion(characters, nil)
     }
     // Muy importante!!! ejecutar la tarea para enviar la peticion al servidor.
     task.resume()
     }
     }*/
}
