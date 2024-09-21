//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Diego Herreros Parron on 21/9/24.
//

import XCTest
@testable import Westeros


final class HouseTests: XCTestCase {

    func test_initialisation_houseStartk() {
        // When
        let sut = House.stark
        
        // Then
        XCTAssertEqual(sut.rawValue, "House Stark")
        XCTAssertNotEqual(sut.rawValue, "house star")
    }
    
    func test_initialisation_houseTargaryen() {
        // When
        let sut = House.targaryen
        
        // Then
        XCTAssertEqual(sut.rawValue, "House Targaryen")
    }
    
    func test_initialisation_houseLannister() {
        // When
        let sut = House.lannister
        
        // Then
        XCTAssertEqual(sut.rawValue, "House Lannister")
        
    }
}
