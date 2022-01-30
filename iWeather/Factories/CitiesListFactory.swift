//
//  CitiesListFactory.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit

struct CitiesListFactory: Factory {
    
    func makeViewController(extraData: Any?) -> UIViewController {
        let viewController = CitiesViewController()
        viewController.viewModel = self.makeViewModel()
        viewController.factory = CityDetailsFactory()
        return UINavigationController(rootViewController:viewController)
    }
    
    private func makeViewModel() -> CitiesViewModel {
        let usecase = self.makeCityUseCase()
        return CitiesViewModel(usecase: usecase)
    }
    
    private func makeCityUseCase() -> CityUsecaseProtocol {
        let repo = self.makeCityRepository()
        return CityUsecase(repo: repo)
    }
    
    private func makeCityRepository() -> CitiesRepositoryProtocol {
        let local = self.makeLocalDatsource()
        let remote = self.makeRemoteDatsource()
        return CitiesRepository(local: local, remote: remote, localStore: UserDefaults.standard)
    }
    
    private func makeLocalDatsource() -> CityDatasource {
        
        return CityLocalDatasource(store: UserDefaults.standard)
    }
    
    private func makeRemoteDatsource() -> CityDatasource {
        let apiClient = APIClient()
        return CityRemoteDatasource(apiClient: apiClient, group: DispatchGroup())
    }
}
