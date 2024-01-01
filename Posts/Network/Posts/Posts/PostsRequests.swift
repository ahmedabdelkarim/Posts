//
//  PostsRequests.swift
//

import Foundation

enum PostsRequests: HttpRequest {
    case getPosts
    case addPost(title: String, body: String)
    case editPost(id: Int, title: String, body: String)
    
    var url: String {
        switch self {
        case .getPosts:
            return RequestUrls.baseUrl + "posts"
        case .addPost:
            return RequestUrls.baseUrl + "posts"
        case .editPost(id: let id, title: let title, body: let body):
            return RequestUrls.baseUrl + "posts/\(id)"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getPosts:
            return .get
        case .addPost:
            return .post
        case .editPost:
            return .put
        }
    }
    
    var bodyParameters: Dictionary<String, Any>? {
        switch self {
        case .getPosts:
            return nil
        case .addPost(let title, let body):
            return ["title":title, "body":body]
        case .editPost(let id, let title, let body):
            return ["title":title, "body":body]
        }
    }
}
