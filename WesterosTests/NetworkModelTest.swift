//
//  WesterosTests.swift
//  WesterosTests
//
//  Created by Diego Herreros Parron on 19/9/24.
//


import XCTest
@testable import Westeros

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<[GOTCharacter]>!
    
    // SetUp actua como inicializador para el test unitario
    // Es un buen punto donde resetear el estado del test
    // Tambien inicializamos las propiedades
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
    }
    
    // Estamos verificando el comportamiento del network model
    // cuando el APIClientProtocol devuelve un success
    func test_getAllCharacters_success() {
        // Given
        let someResult = Result<[GOTCharacter], WesterosError>.success([])
        mock.receivedResult = someResult
        var receivedResult: Result<[GOTCharacter], WesterosError>?
        let expectedURL = URL(string: "https://thronesapi.com/api/v2/Characters")!
        var expectedRequest = URLRequest(url: expectedURL)
        expectedRequest.httpMethod = "GET"

        // When
        sut.getAllCharacters { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
        XCTAssertEqual(
            mock.receivedRequest,
            expectedRequest
        )
    }
    
    func test_getAllCharacters_failure() {
        // Given
        let someResult = Result<[GOTCharacter], WesterosError>.failure(.unknown)
        mock.receivedResult = someResult
        var receivedResult: Result<[GOTCharacter], WesterosError>?

        // When
        sut.getAllCharacters { result in
            receivedResult = result
        }

        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequest)
    }
}
