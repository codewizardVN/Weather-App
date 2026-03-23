//
//  AppContainer.swift
//  Weather-App
//
//  Created by Kobe on 22/3/26.
//

import Foundation

final class AppContainer {
    lazy var apiClient = APIClient()

    lazy var remoteDataSource = WeatherRemoteDataSource(apiClient: apiClient)

    lazy var repository = WeatherRepository(remoteDataSource: remoteDataSource)

    lazy var fetchWeatherUseCase = FetchWeatherUseCase(repository: repository)

    lazy var weatherViewModel = WeatherViewModel(fetchWeatherUseCase: fetchWeatherUseCase)
}
