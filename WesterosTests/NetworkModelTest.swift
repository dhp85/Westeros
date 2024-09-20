//
//  WesterosTests.swift
//  WesterosTests
//
//  Created by Diego Herreros Parron on 19/9/24.
//


// CREACION DE UN UNIT TEST.
import XCTest
@testable import Westeros

final class NetworkModelTests: XCTestCase {
    //1º_ Definir mi unidad.
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<[GOTCharacter]>!
    // este metodo setUp() se va ha ejecutar cada vez que ejecutemos un metodo de XCTestCase
    // SetUp actua como inicializador para el test unitario.
    //Es un buen punto donde resetear el estado del test.
    //Tambien inicializamos las propiedades.
    override func setUp() {
        super.setUp()
        
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
    }
    

    // Estamos verificando el comportamiento del network model
    // cuando el APIClientProtocol devuelve un success

    func test_getAllCharacters_success() {
        // Given, dado que tengo una condiciones.
        let someResult = Result<[GOTCharacter], WesterosError>.success([])
        mock.recivedResult = someResult
        var recivedResult: Result<[GOTCharacter], WesterosError>?
        // When, cuando el objeto haga algo.
        
        sut.getAllCharacters { result in
            recivedResult = result
        }
            
    
        
        // Then, verifico el estado.
        
        XCTAssertEqual(someResult, recivedResult)
        XCTAssert(mock.didCallRequest)
    }
}
