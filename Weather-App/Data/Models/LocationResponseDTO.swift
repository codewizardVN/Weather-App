import Foundation

struct LocationResponseDTO: Decodable {
    let name: String
    let country: String
    let region: String
    let lat: Double
    let lon: Double
    let timezoneID: String
    let localtime: String
    let localtimeEpoch: Int
    let utcOffset: String

    enum CodingKeys: String, CodingKey {
        case name
        case country
        case region
        case lat
        case lon
        case timezoneID = "timezone_id"
        case localtime
        case localtimeEpoch = "localtime_epoch"
        case utcOffset = "utc_offset"
    }

    init(
        name: String,
        country: String,
        region: String,
        lat: Double,
        lon: Double,
        timezoneID: String,
        localtime: String,
        localtimeEpoch: Int,
        utcOffset: String
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        country = try container.decode(String.self, forKey: .country)
        region = try container.decode(String.self, forKey: .region)
        let latStr = try container.decode(String.self, forKey: .lat)
        let lonStr = try container.decode(String.self, forKey: .lon)
        guard let latValue = Double(latStr),
              let lonValue = Double(lonStr) else {
            throw DecodingError.dataCorruptedError(
                forKey: .lat,
                in: container,
                debugDescription: "lat/lon is not a valid Double string"
            )
        }
        lat = latValue
        lon = lonValue
        timezoneID = try container.decode(String.self, forKey: .timezoneID)
        localtime = try container.decode(String.self, forKey: .localtime)
        localtimeEpoch = try container.decode(Int.self, forKey: .localtimeEpoch)
        utcOffset = try container.decode(String.self, forKey: .utcOffset)
    }

    func toDomain() -> Location {
        Location(
            name: name,
            country: country,
            region: region,
            lat: lat,
            lon: lon,
            timezoneID: timezoneID,
            localtime: localtime,
            localtimeEpoch: localtimeEpoch,
            utcOffset: utcOffset
        )
    }
}

extension KeyedDecodingContainer {
    func decodeFlexibleDouble(forKey key: Key) throws -> Double {
        if let doubleValue = try decodeIfPresent(Double.self, forKey: key) {
            return doubleValue
        }

        if let intValue = try decodeIfPresent(Int.self, forKey: key) {
            return Double(intValue)
        }

        if let stringValue = try decodeIfPresent(String.self, forKey: key),
           let doubleValue = Double(stringValue) {
            return doubleValue
        }

        throw DecodingError.dataCorruptedError(
            forKey: key,
            in: self,
            debugDescription: "Expected a Double-compatible value for \(key.stringValue)"
        )
    }

    func decodeFlexibleInt(forKey key: Key) throws -> Int {
        if let intValue = try decodeIfPresent(Int.self, forKey: key) {
            return intValue
        }

        if let doubleValue = try decodeIfPresent(Double.self, forKey: key) {
            return Int(doubleValue)
        }

        if let stringValue = try decodeIfPresent(String.self, forKey: key),
           let intValue = Int(stringValue) {
            return intValue
        }

        throw DecodingError.dataCorruptedError(
            forKey: key,
            in: self,
            debugDescription: "Expected an Int-compatible value for \(key.stringValue)"
        )
    }
}
