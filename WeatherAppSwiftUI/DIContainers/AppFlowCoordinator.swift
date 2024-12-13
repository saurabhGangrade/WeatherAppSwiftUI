//
//  AppFlowCoordinator.swift
//  WeatherApp


import SwiftUI

final class AppFlowCoordinator {
    private let appDIContainer: AppDIContainer

    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }

    func getHomeView() -> HomeView {
        let container = appDIContainer.weatherForeCastSceneDIContainer()
        let actions = WeatherForeCastViewModelActions(showLocationChangeScreen: { presentedAsModal in
            self.getLocationView(presentedAsModal: presentedAsModal)
        })
        return container.makeWeatherForeCastHomeScreen(actions: actions)
    }
    
    func getLocationView(presentedAsModal: Binding<Bool>) -> any View {
        let container = appDIContainer.weatherForeCastSceneDIContainer()
        return container.makeLocationChangeScreen(presentedAsModal: presentedAsModal)
    }
}
