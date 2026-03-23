import Testing
@testable import Weather_App

final class MockWeatherRepository: WeatherRepositoryProtocol {
    var expectedWeather = Weather(
        cityName: "London",
        temperature: 18,
        conditionDescription: "Cloudy"
    )
    var receivedCity: String?
    var error: Error?
    
    private enum MockError: Error { case notImplemented }
    
    func fetchCurrentWeather(for city: String) async throws -> Weather {
        receivedCity = city
        
        if let error {
            throw error
        }
        
        return expectedWeather
    }
}


private enum WeatherRepositorySpyError: Error {
    case offline
}


private enum TestError: Error {
    case sample
}

struct Weather_AppTests {
    @Test func execute_returnsWeatherFromRepository() async throws {
        let repository = MockWeatherRepository()
        let expectedWeather = repository.expectedWeather
        let useCase = await FetchWeatherUseCase(repository: repository)
        
        let weather = try await useCase.fetchCurrentWeather(for: "London")
        
        #expect(weather == expectedWeather)
    }
    
    @Test func execute_forwardsCityToRepository() async throws {
        let repository = MockWeatherRepository()
        let useCase = await FetchWeatherUseCase(repository: repository)
        
        _ = try await useCase.fetchCurrentWeather(for: "Tokyo")
        
        #expect(repository.receivedCity == "Tokyo")
    }
    
    @Test func execute_propagatesRepositoryError() async {
        let repository = MockWeatherRepository()
        repository.error = TestError.sample
        
        let useCase = await FetchWeatherUseCase(repository: repository)
        
        do {
            _ = try await useCase.fetchCurrentWeather(for: "Paris")
            Issue.record("Expected error to be thrown, but no error was thrown.")
        } catch {
            #expect(error is TestError)
        }
    }
}
