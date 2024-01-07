//
//  NetworkManager.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import Foundation

struct NetworkManager<T: Decodable>: DataFetchable {
  private let url = "https://my-json-server.typicode.com/ValseLee/UMC-5th-Conference/fashionItems"
  
  public func fetchItems() async throws -> [T] {
    guard let url = URL(string: url) else { throw NetworkError.invalidUrl }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard
      let response = response as? HTTPURLResponse,
      response.statusCode == 200 else { throw NetworkError.networkError }
    
    guard let result = try? JSONDecoder().decode([T].self, from: data) else { throw NetworkError.invalidDataFormat }
    
    return result
  }
}

enum NetworkError: Error {
  case invalidUrl
  case networkError
  case invalidDataFormat
}
