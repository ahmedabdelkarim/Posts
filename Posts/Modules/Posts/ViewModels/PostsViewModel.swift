//
//  PostsViewModel.swift
//

import Foundation

class PostsViewModel {
    // MARK: - Properties
    let postsRepository: PostsRepositoryProtocol?
    private(set) var posts = [Post]()
    
    // MARK: - Init
    init(postsRepository: PostsRepositoryProtocol?) {
        self.postsRepository = postsRepository
    }
    
    // MARK: - Methods
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void) {
        postsRepository?.getPosts(success: { posts in
            self.posts = posts
            success(posts)
        }, failure: { error in
            failure(error)
        })
    }
}
