import Foundation

struct Weather: Equatable, Sendable {
    let cityName: String
    let temperature: Double
    let conditionDescription: String
}
