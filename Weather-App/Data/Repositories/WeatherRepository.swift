import Foundation

struct WeatherRepository: WeatherRepositoryProtocol {
    private let remoteDataSource: WeatherRemoteDataSourceProtocol

    init(remoteDataSource: WeatherRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchCurrentWeather(for city: String) async throws -> Weather {
        let response = try await remoteDataSource.fetchCurrentWeather(for: city)
        return response.toDomain()
    }
}
