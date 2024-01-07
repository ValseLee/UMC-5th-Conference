//
//  EndpointRouter.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import Foundation

enum Endpoint: String {
  case fashionItem
  case shopInfo
  
  var urlEndpoint: URL? {
    switch self {
    case .fashionItem:
      return URL(string: "https://my-json-server.typicode.com/ValseLee/UMC-5th-Conference/\(self.rawValue)")
    case .shopInfo:
      return URL(string: "https://my-json-server.typicode.com/ValseLee/UMC-5th-Conference/\(self.rawValue)")
    }
  }
}
