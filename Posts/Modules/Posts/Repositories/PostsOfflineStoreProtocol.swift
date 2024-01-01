//
//  PostsOfflineStoreProtocol.swift
//

import Foundation

protocol PostsOfflineStoreProtocol {
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void)
    func storePosts(_ posts: [Post], success: @escaping () -> Void, failure: @escaping (Error?) -> Void)
}
