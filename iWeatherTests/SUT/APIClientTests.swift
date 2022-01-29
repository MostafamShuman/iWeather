//
//  APIClientTests.swift
//  iWeatherTests
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import XCTest
@testable import iWeather

class APIClientTests: XCTestCase {
    var sut: APIClientProtocol!
    
    func testRecipesRetrieved() {
        // given
        sut = APIClient()
        let promise = expectation(description: "APIClientExpectation")
        // when
        sut.execute(request: RequestBuilder.fetchCity(id: 839722)) { (completion: Result<City, Error>) in
            // then
            switch completion {
            case .failure(_):
                XCTFail()
            case .success(let model):
                XCTAssertNotNil(model)
                XCTAssertTrue(model.consolidatedWeather?.count ?? 0 > 0)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
    }
}

