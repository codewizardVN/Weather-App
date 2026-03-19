import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

struct APIClient: APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        throw URLError(.badURL)
    }
}
