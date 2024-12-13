//
//  WeatherForeCastSceneDIContainer.swift
//  WeatherApp


import SwiftUI

final class WeatherForeCastSceneDIContainer {
    private let dependencies: Dependencies
    private let sharedRepository: WeatherRepository
    
    init(dependencies: Dependencies,
         sharedRepository: WeatherRepository) {
        self.dependencies = dependencies
        self.sharedRepository = sharedRepository
    }
    
    // MARK: - Use Cases
    private func makeWeatherForeCastUseCase() -> WeatherForeCastUseCase {
        return WeatherForeCastUseCase(repository: makeWeatherRepository())
    }

    private func makeWeatherForeCastUseCase() -> LocationChangeUseCase {
        return LocationChangeUseCase(repository: makeWeatherRepository())
    }
    
    // MARK: - Repositories
    private func makeWeatherRepository() -> WeatherRepository {
        return sharedRepository
    }

    // MARK: - ViewModel
    private func makeWeatherForeCastViewModel(actions: WeatherForeCastViewModelActions) -> WeatherForeCastViewModel {
        return WeatherForeCastViewModel(useCase: makeWeatherForeCastUseCase(), actions: actions)
    }

    private func makeLocationChangeViewModel() -> LocationChangeViewModel {
        return LocationChangeViewModel(useCase: makeWeatherForeCastUseCase())
    }

    func makeWeatherForeCastHomeScreen(actions: WeatherForeCastViewModelActions) -> HomeView {
        return HomeView(viewModel: makeWeatherForeCastViewModel(actions: actions))
    }
    
    func makeLocationChangeScreen(presentedAsModal: Binding<Bool>) -> any View {
        return LocationChangeView(viewModel: makeLocationChangeViewModel(), presentedAsModal: presentedAsModal)
    }
}
