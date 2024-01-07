//
//  DataFetchable.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import UIKit

protocol DataFetchable {
  func fetchItems<T: Decodable>(
    _ type: T.Type,
    from url: Endpoint
  ) async throws -> [T]
}
