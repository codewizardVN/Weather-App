import Foundation

enum AppConfig {
    static var weatherstackAPIKey: String? {
        infoDictionaryValue
    }

    private static var infoDictionaryValue: String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "WEATHERSTACK_API_KEY") as? String else {
            return nil
        }

        return normalized(value)
    }
    private static func normalized(_ value: String) -> String? {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? nil : trimmedValue
    }
}

enum AppConfigError: LocalizedError {
    case missingWeatherstackAPIKey

    var errorDescription: String? {
        switch self {
        case .missingWeatherstackAPIKey:
            return "Missing WEATHERSTACK_API_KEY. Set it through the app build configuration."
        }
    }
}
