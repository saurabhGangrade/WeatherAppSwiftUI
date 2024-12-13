//
//  WeatherForeCastViewModel.swift
//  WeatherAppSwiftUI
//

import SwiftUI

struct WeatherForeCastViewModelActions {
    let showLocationChangeScreen: (_ presentedAsModal: Binding<Bool>) -> any View
}


class WeatherForeCastViewModel: ObservableObject {
    private let useCase: WeatherForeCastUseCaseProtocol
    private var actions: WeatherForeCastViewModelActions
    
    // Using @Published to make the weather details observable for SwiftUI
    @Published private var weatherDetailsModel: WeatherForeCastDisplayModel?
    
    // Track loading state for UI
    @Published var isCityNameNotFound: Bool = true
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // Initializer
    init(useCase: WeatherForeCastUseCaseProtocol,
         actions: WeatherForeCastViewModelActions) {
        self.useCase = useCase
        self.actions = actions
    }
    
    // Fetch weather details from the use case
    
    func showLoaderAndRestetErrorMessage() {
        self.isLoading = true
        self.errorMessage = nil
    }
    
    func fetchWeatherDetails() {
        self.useCase.fetchWeatherForeCast { [weak self] result in
            guard let self = self else { return }
//            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let responseDTO):
                    self.weatherDetailsModel = WeatherResponseToDisplayMapper.convertResponseToDisplay(weatherForeCastResponseModel: responseDTO)
                    self.isCityNameNotFound = false
                case .failure(let error):
                    switch error {
                    case .noSelectedCtyFound:
                        self.isCityNameNotFound = true
                        self.errorMessage = Localizable.noSelectedCity
                    case .noDataFound:
                        self.errorMessage = Localizable.noWeatherData
                    default:
                        self.errorMessage = Localizable.errorWhileFetching
                    }
                }
//            }
        }
    }
    
    func isCityModified() -> Bool {
        return weatherDetailsModel?.cityName != useCase.fetchSelectedCityName()
    }
    
    // MARK: - Data Access Methods
    
    func getCityName() -> String {
        return weatherDetailsModel?.cityName ?? ""
    }

    func getTemperatureType(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return weatherList[index].weatherType
    }

    func getTemperatureTypeImage(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return weatherList[index].weatherIcon
    }

    func getCurrentTemperature(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return "\(weatherList[index].temperature)°C"
    }

    func getMaxTemperature(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return "\(weatherList[index].temperatureMax)°C"
    }

    func getMinTemperature(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return "\(weatherList[index].temperatureMin)°C"
    }

    func getTodaysDate(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return Localizable.today + " \(weatherList[index].date)"
    }

    func getTodaysDay(index: Int) -> String {
        guard let weatherList = weatherDetailsModel?.WeatherForeCastByDate,
              weatherList.count > index else {
            return ""
        }
        return index == 0 ? Localizable.today : weatherList[index].day
    }

    func getDayCount() -> Int {
        return weatherDetailsModel?.WeatherForeCastByDate.count ?? 0
    }

    func getWeatherDetailsForFullDay(day: Int) -> [WeatherForeCastDetails] {
        guard let weatherForeCastByDate = weatherDetailsModel?.WeatherForeCastByDate,
              weatherForeCastByDate.count > day,
              let weatherForeCastDetails = weatherForeCastByDate[day].weatherForeCastDetails else {
            return []
        }
        return weatherForeCastDetails
    }
    
    func showLocationView(_ presentedAsModal: Binding<Bool>) -> some View {
        return actions.showLocationChangeScreen(presentedAsModal)
    }
}
