//
//  Network.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(_ endpoint: NetworkEndPoint) async throws -> T
}

final class Network {
    
    func request<T: Decodable>(_ endpoint: NetworkEndPoint) async throws -> T {
        var components = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: true)!
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw SwiftHubError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SwiftHubError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error:", error)
            throw SwiftHubError.invalidData
        }
    }
}

final class FakeNetwork: NetworkProtocol {
    var response: [RepositoryDTO]
    
    init(response: [RepositoryDTO]) {
        self.response = response
    }    
    
    func request<T>(_ endpoint: any NetworkEndPoint) async throws -> T where T : Decodable {
        guard let result = response as? T else { throw NSError() }
        return result
    }
}
