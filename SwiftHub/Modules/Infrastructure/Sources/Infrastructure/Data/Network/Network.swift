//
//  Network.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation
import Core

protocol NetworkProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: NetworkEndPoint, keyPath: String?) async throws -> T
}

final class Network: NetworkProtocol {
    
    func request<T: Decodable>(_ endpoint: NetworkEndPoint, keyPath: String?) async throws -> T {
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
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            var nestedObject: Any = jsonObject
            
            if let keyPath {
                let keys = keyPath.split(separator: ".").map(String.init)
                for key in keys {
                    if let dict = nestedObject as? [String: Any], let next = dict[key] {
                        nestedObject = next
                    } else {
                        throw SwiftHubError.invalidData
                    }
                }
            }
            
            let nestedData = try JSONSerialization.data(withJSONObject: nestedObject)
            return try JSONDecoder().decode(T.self, from: nestedData)
        } catch {
            print("Decoding error:", error)
            throw SwiftHubError.invalidData
        }
    }
}

final class FakeNetwork<C: Sendable>: NetworkProtocol {
    private let response: [C]
    
    init(response: [C]) {
        self.response = response
    }    
    
    func request<T>(_ endpoint: any NetworkEndPoint, keyPath: String?) async throws -> T where T : Decodable {
        guard let result = response as? T else { throw NSError() }
        return result
    }
}
