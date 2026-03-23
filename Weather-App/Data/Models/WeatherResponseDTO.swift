import Foundation

struct WeatherResponseDTO: Decodable {
    let request: WeatherRequestDTO
    let location: LocationResponseDTO
    let current: CurrentWeatherDTO
    
    func toDomain() -> Weather {
        Weather(
            cityName: location.name,
            country: location.country,
            region: location.region,
            temperature: current.temperature,
            conditionDescription: current.weatherDescriptions.first ?? "Unknown",
            windSpeed: current.windSpeed,
            humidity: current.humidity,
            feelsLike: current.feelslike,
            weatherIconURL: current.weatherIcons.first,
            isDay: current.isDay == "yes",
            location: location.toDomain()
        )
    }
}
