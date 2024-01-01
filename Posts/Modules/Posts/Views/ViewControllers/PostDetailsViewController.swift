//
//  PostDetailsViewController.swift
//

import UIKit

class PostDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: PostDetailsViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPostDetails()
    }
    
    // MARK: - Methods
    func showPostDetails() {
        guard let viewModel = viewModel, let post = viewModel.post else {
            return
        }
        
        // display title
        titleLabel.text = post.title
        
        // display body
        bodyLabel.text = post.body
    }
    
    private func updatePost(with post: Post) {
        viewModel?.updatePost(with: post)
        
        self.titleLabel.text = post.title
        self.bodyLabel.text = post.body
    }
    
    // MARK: - Actions
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "editPost":
            if let vc = segue.destination as? AddPostViewController {
                vc.viewModel = DependencyRegistry.default.addPostViewModel(postToEdit: viewModel?.post)
                vc.delegate = self
            }
        default:
            break
        }
    }
}

extension PostDetailsViewController: AddPostViewControllerDelegate {
    func addPostViewController(_ viewController: AddPostViewController, didAdd post: Post) {
        // refresh items
        DispatchQueue.main.async { [weak self] in
            self?.updatePost(with: post)
        }
    }
}
