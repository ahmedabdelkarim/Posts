//
//  PostsResponses.swift
//

import Foundation

struct PostsResponse: Decodable {
    let id: Int
    let title: String?
    let body: String?
}
