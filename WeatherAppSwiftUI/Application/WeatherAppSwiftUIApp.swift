//
//  WeatherAppSwiftUIApp.swift
//  WeatherAppSwiftUI
//

import SwiftUI


@main
struct WeatherAppSwiftUIApp: App {
    let appFlowCoordinator = AppFlowCoordinator(appDIContainer: AppDIContainer())
    var body: some Scene {
        WindowGroup {
            appFlowCoordinator.getHomeView()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
