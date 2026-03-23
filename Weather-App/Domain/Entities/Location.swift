import Foundation

struct Location: Codable, Equatable, Sendable {
    let name: String
    let country: String
    let region: String
    let lat: Double
    let lon: Double
    let timezoneID: String
    let localtime: String
    let localtimeEpoch: Int
    let utcOffset: String

    init(
        name: String,
        country: String,
        region: String,
        lat: Double,
        lon: Double,
        timezoneID: String = "",
        localtime: String = "",
        localtimeEpoch: Int = 0,
        utcOffset: String = ""
    ) {
        self.name = name
        self.country = country
        self.region = region
        self.lat = lat
        self.lon = lon
        self.timezoneID = timezoneID
        self.localtime = localtime
        self.localtimeEpoch = localtimeEpoch
        self.utcOffset = utcOffset
    }
}
