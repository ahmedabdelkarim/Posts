//
//  DependencyRegistry.swift
//

import Foundation

struct DependencyRegistry {
    // MARK: - Properties
    static let `default`: DependencyRegistry = DependencyRegistry()
    
    // MARK: - Private Init
    private init() { }
    
    // MARK: - Methods [PostsViewModel]
    func postsViewModelWithOnlineOnly() -> PostsViewModel {
        let onlinePostsService = PostsService()
        let instance = PostsViewModel(postsRepository: PostsRepository(onlineService: onlinePostsService, offlineStore: nil))
        
        return instance
    }
    
    func postsViewModelWithOnlineAndOffline() -> PostsViewModel {
        let onlinePostsService = PostsService()
        let offlinePostsService = PostsStore()
        let instance = PostsViewModel(postsRepository: PostsRepository(onlineService: onlinePostsService, offlineStore: offlinePostsService))
        
        return instance
    }
    
    func addPostViewModel(postToEdit: Post?) -> AddPostViewModel {
        let onlinePostsService = PostsService()
        let instance = AddPostViewModel(postsRepository: PostsRepository(onlineService: onlinePostsService, offlineStore: nil), postToEdit: postToEdit)
        
        return instance
    }
}
