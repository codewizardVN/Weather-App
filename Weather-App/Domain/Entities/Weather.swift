import Foundation

struct Weather: Equatable, Sendable {
    let cityName: String
    let country: String
    let region: String
    let temperature: Double
    let conditionDescription: String
    let windSpeed: Double
    let humidity: Int
    let feelsLike: Double
    let weatherIconURL: String?
    let isDay: Bool
    let location: Location

    init(
        cityName: String,
        country: String = "",
        region: String = "",
        temperature: Double,
        conditionDescription: String,
        windSpeed: Double = 0,
        humidity: Int = 0,
        feelsLike: Double = 0,
        weatherIconURL: String? = nil,
        isDay: Bool = true,
        location: Location = .init(name: "", country: "", region: "", lat: 0, lon: 0)
    ) {
        self.cityName = cityName
        self.country = country
        self.region = region
        self.temperature = temperature
        self.conditionDescription = conditionDescription
        self.windSpeed = windSpeed
        self.humidity = humidity
        self.feelsLike = feelsLike
        self.weatherIconURL = weatherIconURL
        self.isDay = isDay
        self.location = location
    }
}
