//
//  PostsService.swift
//

import Foundation

struct PostsService: PostsOnlineServiceProtocol {
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void) {
        // fetch online using HttpClient
        HttpClient().perform(request: PostsRequests.getPosts, responseType: [PostsResponse].self, success: { response in
            // mapping
            let posts = response.body?.map { postDecodable -> Post in
                return Post(id: postDecodable.id,
                           title: postDecodable.title,
                           body: postDecodable.body)
            }
            
            success(posts ?? [])
        }, failure: { error in
            failure(error)
        })
    }
    
    func addPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void) {
        HttpClient().perform(request: PostsRequests.addPost(title: post.title ?? "", body: post.body ?? ""), responseType: PostsResponse.self, success: { response in
            // mapping
            let post = Post(id: response.body?.id ?? 0, title: response.body?.title, body: response.body?.body)
            
            success(post)
        }, failure: { error in
            failure(error)
        })
    }
    
    func editPost(_ post: Post, success: @escaping (Post) -> Void, failure: @escaping (Error?) -> Void) {
        HttpClient().perform(request: PostsRequests.editPost(id: post.id, title: post.title ?? "", body: post.body ?? ""), responseType: PostsResponse.self, success: { response in
            // mapping
            let post = Post(id: response.body?.id ?? 0, title: response.body?.title, body: response.body?.body)
            
            success(post)
        }, failure: { error in
            failure(error)
        })
    }
}
