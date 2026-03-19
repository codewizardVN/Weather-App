import Foundation

protocol WeatherRepositoryProtocol {
    func fetchCurrentWeather(for city: String) async throws -> Weather
}
