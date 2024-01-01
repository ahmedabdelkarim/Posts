//
//  PostsStore.swift
//

import Foundation

struct PostsStore: PostsOfflineStoreProtocol {
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - fetch from CoreData in background
        failure(nil)
    }
    
    func storePosts(_ posts: [Post], success: @escaping () -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: - store in CoreData in background
        failure(nil)
    }
}
