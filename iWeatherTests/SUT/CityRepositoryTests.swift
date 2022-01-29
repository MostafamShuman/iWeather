//
//  CityRepositoryTests.swift
//  iWeatherTests
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import XCTest
@testable import iWeather

class CitRepositoryTests: XCTestCase {
    var sut: CitiesRepositoryProtocol!
    
    func testFetchDataFromRemoteAndUpdateItLocal() {
        let mockUserDefaults = UserDefaults(suiteName: "mocks")!
        let testData = City.parse(jsonFile: "city_2459115")
        let promise = expectation(description: "client with data")
        let apiClient = APIClientMocks(data: testData)
        let remoteDatasporce = CityRemoteDatasource(apiClient: apiClient, group: DispatchGroup())
        let localDatasource = CityLocalDatasource(store: mockUserDefaults)
        
        sut = CitiesRepository(local: localDatasource, remote: remoteDatasporce, localStore: mockUserDefaults)
        sut.fetchCities { result in
            switch result {
            case .success(let cities):
                XCTAssertTrue(cities.count > 0)
                if let storedData = mockUserDefaults.value(forKey: "city_2459115") as? Data,
                   let city = try? PropertyListDecoder().decode(City.self, from: storedData) {
                    XCTAssertTrue(city.woeid == 2459115 )
                } else {
                    XCTFail()
                }
            case .failure(_):
                XCTFail()
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)

    }
}

