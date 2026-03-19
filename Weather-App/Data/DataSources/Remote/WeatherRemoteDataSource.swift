import Foundation

protocol WeatherRemoteDataSourceProtocol {
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponseDTO
}

struct WeatherRemoteDataSource: WeatherRemoteDataSourceProtocol {
    func fetchCurrentWeather(for city: String) async throws -> WeatherResponseDTO {
        WeatherResponseDTO(
            cityName: city,
            temperature: 29,
            conditionDescription: "Sunny"
        )
    }
}
