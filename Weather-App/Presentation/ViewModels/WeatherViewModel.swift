import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    private let fetchWeatherUseCase: FetchWeatherUseCase

    @Published var city = "Ho Chi Minh City"
    @Published var weather: Weather?
    @Published var isLoading = false
    @Published var errorMessage: String?

    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }

    func loadWeather() async {
        isLoading = true
        errorMessage = nil

        do {
            weather = try await fetchWeatherUseCase.execute(for: city)
        } catch {
            weather = nil
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
