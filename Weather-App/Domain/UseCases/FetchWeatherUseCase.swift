import Foundation

struct FetchWeatherUseCase {
    private let repository: WeatherRepositoryProtocol

    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for city: String) async throws -> Weather {
        try await repository.fetchCurrentWeather(for: city)
    }
}
