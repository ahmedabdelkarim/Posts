//
//  AddPostViewModel.swift
//

import Foundation

class AddPostViewModel {
    // MARK: - Properties
    let postsRepository: PostsRepositoryProtocol?
    let postToEdit: Post?
    
    // MARK: - Init
    init(postsRepository: PostsRepositoryProtocol?, postToEdit: Post?) {
        self.postsRepository = postsRepository
        self.postToEdit = postToEdit
    }
    
    // MARK: - Methods
    func addOrEditPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void) {
        
        if postToEdit == nil {
            // add new post
            postsRepository?.addPost(post, success: { post in
                success(post)
            }, failure: { error in
                failure(error)
            })
        } else {
            // edit existing post
            postsRepository?.editPost(post, success: { post in
                success(post)
            }, failure: { error in
                failure(error)
            })
        }
    }
}
