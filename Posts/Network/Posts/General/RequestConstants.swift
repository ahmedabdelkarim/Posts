//
//  RequestConstants.swift
//

import Foundation

struct RequestUrls {
    static let baseUrl = "https://jsonplaceholder.typicode.com/"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}
