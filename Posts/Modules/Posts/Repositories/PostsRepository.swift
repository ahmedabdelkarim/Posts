//
//  PostsRepository.swift
//

import Foundation

struct PostsRepository: PostsRepositoryProtocol {
    let onlineService: PostsOnlineServiceProtocol?
    let offlineStore: PostsOfflineStoreProtocol?
    
    init(onlineService: PostsOnlineServiceProtocol?, offlineStore: PostsOfflineStoreProtocol?) {
        self.onlineService = onlineService
        self.offlineStore = offlineStore
    }
    
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void) {
        // try fetch online, if failed try fetch offline
        onlineService?.getPosts(success: { posts in
            success(posts)
            
            // update offline store if exists
            offlineStore?.storePosts(posts, success: {
                // TODO: - handle
            }, failure: { error in
                if let error = error {
                    print(error)
                }
                // TODO: - handle
            })
        }, failure: { error in
            // if no offline store exists
            guard let offlineStore = offlineStore else {
                failure(error)
                return
            }
            
            // use offline store if exists
            offlineStore.getPosts(success: { posts in
                success(posts)
            }, failure: { error in
                failure(error)
            })
        })
    }
    
    func addPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void) {
        onlineService?.addPost(post, success: { post in
            success(post)
        }, failure: { error in
            failure(error)
        })
    }
    
    func editPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void) {
        onlineService?.editPost(post, success: { post in
            success(post)
        }, failure: { error in
            failure(error)
        })
    }
}
