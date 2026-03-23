import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

struct APIClient: APIClientProtocol {
    private let baseUrl: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        baseUrl: URL = URL(string: "https://api.weatherstack.com")!,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.baseUrl = baseUrl
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try makeURLRequest(from: endpoint)
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse =  response as? HTTPURLResponse else { throw APIClientError.invalidResponse }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIClientError.httpError(statusCode: httpResponse.statusCode)
        }
        
        if let weatherStackError = try? decoder.decode(WeatherStackErrorResponseDTO.self, from: data), weatherStackError.success == false, let error = weatherStackError.error {
            throw APIClientError.weatherstackError(code: error.code, type: error.type, info: error.info)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIClientError.decodingFailed(error)
        }
    }
    
    private func makeURLRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            throw APIClientError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw APIClientError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
}

enum APIClientError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingFailed(Error)
    case weatherstackError(code: Int, type: String, info: String)
}
