//
//  PostDetailsViewModel.swift
//

import Foundation

class PostDetailsViewModel {
    // MARK: - Properties
    private(set) var post: Post!
    
    // MARK: - Init
    init(post: Post) {
        self.post = post
    }
    
    // MARK: - Methods
    func updatePost(with post: Post) {
        self.post = post
    }
}
