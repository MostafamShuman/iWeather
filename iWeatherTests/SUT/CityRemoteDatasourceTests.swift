//
//  CitryRemoteDatasourceTests.swift
//  iWeatherTests
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import XCTest
@testable import iWeather

class CityRemoteDatasourceTests: XCTestCase {
    var sut: CityDatasource!
    
    func testFetchCityByIDWithData() {
        let testData = City.parse(jsonFile: "city_2459115")
        let promise = expectation(description: "client with data")
        let apiClient = APIClientMocks(data: testData)
        sut = CityRemoteDatasource(apiClient: apiClient, group: DispatchGroup())
        
        sut.city(with: 2459115) { results in
            switch results {
            case .success(let city):
                XCTAssertTrue(city.consolidatedWeather?.count ?? 0 > 0)
                XCTAssertEqual(city.woeid, 2459115)
            case .failure(_):
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testFetchCityByIDWithError() {
        let error = NetworkError.requestFailed
        let promise = expectation(description: "client with error")
        let apiClient = APIClientMocks(error: error)
        sut = CityRemoteDatasource(apiClient: apiClient, group: DispatchGroup())
        sut.city(with: 2459115) { results in
            switch results {
            case .success(_):
                XCTFail()
            case .failure(let retrivedError ):
                if let retrivedError = retrivedError as? NetworkError {
                    XCTAssertEqual(error.localizedDescription, retrivedError.localizedDescription)
                } else {
                    XCTFail()
                }
                
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    
    func testFetchCitiesithData() {
        let testData = City.parse(jsonFile: "city_2459115")
        let promise = expectation(description: "client with data")
        let apiClient = APIClientMocks(data: testData)
        sut = CityRemoteDatasource(apiClient: apiClient, group: DispatchGroup())
        
        sut.cities { results in
            switch results {
            case .success(let cities):
                XCTAssertTrue(cities.count  > 0)
                XCTAssertEqual(cities.count, AppConstants.citiesIDs.count)
            case .failure(_):
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func testFetchCitiesWithError() {
        let error = NetworkError.requestFailed
        let promise = expectation(description: "client with error")
        let apiClient = APIClientMocks(error: error)
        sut = CityRemoteDatasource(apiClient: apiClient, group: DispatchGroup())
        sut.cities { results in
            switch results {
            case .success(_):
                XCTFail()
            case .failure(let retrivedError ):
                XCTAssertNotNil(retrivedError)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
    
}
