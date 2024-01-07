//
//  DataFetchable.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import UIKit

protocol DataFetchable<T> {
  associatedtype T: Decodable
  func fetchItems() async throws -> T
}
