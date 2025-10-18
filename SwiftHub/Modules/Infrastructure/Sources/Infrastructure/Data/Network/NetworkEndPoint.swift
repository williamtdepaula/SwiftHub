//
//  NetworkEndPoint.swift
//  Infrastructure
//
//  Created by Willian de Paula on 17/10/25.
//

import Foundation

protocol NetworkEndPoint: Sendable {
    var url: URL { get }
    var queryItems: [URLQueryItem] { get }
}
