//
//  EndpointRouter.swift
//  UMC-Conference-Example
//
//  Created by Celan on 1/7/24.
//

import Foundation

enum Endpoint: String {
  case fashionItems
  case shopInfos
  
  private var baseUrl: String {
    "https://my-json-server.typicode.com/ValseLee/UMC-5th-Conference/"
  }
  
  public var url: URL? {
    URL(string: "\(baseUrl)\(self.rawValue)")
  }
}
