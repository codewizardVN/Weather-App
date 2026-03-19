import Foundation

struct WeatherResponseDTO: Decodable {
    let cityName: String
    let temperature: Double
    let conditionDescription: String

    func toDomain() -> Weather {
        Weather(
            cityName: cityName,
            temperature: temperature,
            conditionDescription: conditionDescription
        )
    }
}
