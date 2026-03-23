import Foundation
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {
    private let fetchWeatherUseCase: FetchWeatherUseCase
    
    @Published var weather: Weather?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    func loadWeather(for city: String) async {
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedCity.isEmpty else {
            errorMessage = "City name cannot be empty"
            weather = nil
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            weather = try await fetchWeatherUseCase.fetchCurrentWeather(for: trimmedCity)
        } catch {
            weather = nil
            errorMessage = mapErrorToMessage(error)
        }
        
        isLoading = false
    }
    
    private func mapErrorToMessage(_ error: Error) -> String {
        if let apiError = error as? APIClientError {
            switch apiError {
            case .invalidURL:
                return "The request URL is invalid."
            case .invalidResponse:
                return "The server response is invalid."
            case .httpError:
                return "Unable to fetch weather data right now."
            case .decodingFailed:
                return "Unable to read weather data."
            case let .weatherstackError(_, type, info):
                switch type {
                case "invalid_access_key":
                    return "The API key is invalid."
                case "missing_access_key":
                    return "The API key is missing."
                case "query_not_found":
                    return "The requested city could not be found."
                case "request_failed":
                    return "Unable to connect to the weather service."
                default:
                    return info
                }
            }
        }

        if let configError = error as? AppConfigError {
            switch configError {
            case .missingWeatherstackAPIKey:
                return "Missing API key configuration."
            }
        }
        
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "No internet connection."
            case .timedOut:
                return "The request timed out. Please try again."
            default:
                return "A network error occurred. Please try again."
            }
        }
        
        return "Something went wrong. Please try again."
    }
}
