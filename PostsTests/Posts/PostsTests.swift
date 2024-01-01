//
//  PostsTests.swift
//  PostsTests
//

import XCTest
@testable import Posts

class PostsTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPostsAssignCorrectly() throws {
        let mockPostsRepository = MockPostsRepository(numberOfPosts: 3)
        let vm = PostsViewModel(postsRepository: mockPostsRepository)
        
        vm.getPosts(success: { posts in
            XCTAssertNotNil(vm.posts)
            XCTAssertEqual(vm.posts.count, mockPostsRepository.numberOfPosts)
        }, failure: { error in
            XCTFail("Expected to succeed, but got error: \(String(describing: error))")
        })
    }
    
    //other test cases..
    
}

private class MockPostsRepository: PostsRepositoryProtocol {
    // testing properties
    var numberOfPosts = 3
    
    // testing init
    convenience init(numberOfPosts: Int) {
        self.init(onlineService: nil, offlineStore: nil)
        
        self.numberOfPosts = numberOfPosts
    }
    
    required init(onlineService: PostsOnlineServiceProtocol?, offlineStore: PostsOfflineStoreProtocol?) {
        // do nothing
    }
    
    func getPosts(success: @escaping ([Post]) -> Void, failure: @escaping (Error?) -> Void) {
        // return dummy list
        var posts = [Post]()
        
        for index in 1...numberOfPosts {
            posts.append(Post(id: index, title: "", body: ""))
        }
        
        success(posts)
    }
}
