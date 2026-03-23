import Foundation

protocol WeatherRemoteDataSourceProtocol {
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponseDTO
}

struct WeatherRemoteDataSource: WeatherRemoteDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    private func configuredAPIKey() throws -> String {
        guard let apiKey = AppConfig.weatherstackAPIKey else {
            throw AppConfigError.missingWeatherstackAPIKey
        }

        return apiKey
    }
    
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponseDTO {
        let apiKey = try configuredAPIKey()
        let endpoint = Endpoint(
            path: "/current",
            method: HTTPMethod.get,
            queryItems: [
                URLQueryItem(name: "access_key", value: apiKey),
                URLQueryItem(name: "query", value: city),
            ]
        )
        return try await apiClient.request(endpoint)
    }
}
