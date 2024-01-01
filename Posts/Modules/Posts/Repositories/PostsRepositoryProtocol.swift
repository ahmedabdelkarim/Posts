//
//  PostsRepositoryProtocol.swift
//

import Foundation

protocol PostsRepositoryProtocol {
    init(onlineService: PostsOnlineServiceProtocol?, offlineStore: PostsOfflineStoreProtocol?)
    
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void)
    
    func addPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void)
    
    func editPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void)
}
