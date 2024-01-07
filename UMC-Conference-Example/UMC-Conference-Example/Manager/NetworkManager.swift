//
//  NetworkManager.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import Foundation

struct NetworkManager: DataFetchable {
  internal func fetchItems<T: Decodable>(
    _ type: T.Type,
    from endpoint: Endpoint
  ) async throws -> [T] {
    guard let url = endpoint.url else { throw NetworkError.invalidUrl }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard
      let response = response as? HTTPURLResponse,
      response.statusCode == 200 else { throw NetworkError.networkError }
    
    guard let result = try? JSONDecoder().decode([T].self, from: data) else {
      throw NetworkError.invalidDataFormat
    }
    
    return result
  }
}

enum NetworkError: Error {
  case invalidUrl
  case networkError
  case invalidDataFormat
}
