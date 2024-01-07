//
//  FashionItem.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import Foundation

struct FashionItem: Decodable, Hashable {
  var id: UUID { UUID() }
  var name: String
  var imageUrl: String
  var category: String
  var size: String?
  
  static let mock: [FashionItem] = [
    .init(name: "맨투맨", imageUrl: "https://avatars.githubusercontent.com/u/82270058?v=4", category: "의류"),
    .init(name: "목걸이", imageUrl: "https://avatars.githubusercontent.com/u/82270058?v=4", category: "액세서리"),
    .init(name: "캔버스", imageUrl: "https://avatars.githubusercontent.com/u/82270058?v=4", category: "신발", size: "260"),
  ]
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(imageUrl)
  }
}
