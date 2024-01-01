//
//  AddPostViewController.swift
//

import UIKit

class AddPostViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    var viewModel: AddPostViewModel?
    weak var delegate: AddPostViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPostToEditIfExist()
    }
    
    // MARK: - Methods
    private func loadPostToEditIfExist() {
        if let postToEdit = viewModel?.postToEdit {
            titleTextField.text = postToEdit.title
            bodyTextView.text = postToEdit.body
        }
    }
    
    private func getPost() -> Post? {
        guard titleTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty == false &&
                bodyTextView.text?.trimmingCharacters(in: .whitespaces).isEmpty == false else {
            return nil
        }
        
        let title = titleTextField.text
        let body = bodyTextView.text
        
        let postId = viewModel?.postToEdit?.id ?? 0
        let post = Post(id: postId, title: title, body: body)
        
        return post
    }
    
    // MARK: - Actions
    @IBAction func done(_ sender: Any) {
        if let post = getPost() {
            viewModel?.addOrEditPost(post, success: { [weak self] post in
                guard let self = self else { return }
                
                self.delegate?.addPostViewController(self, didAdd: post)
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }, failure: { error in
                Alerts.showInfoAlert(viewController: self, title: "Error", message: error?.localizedDescription)
            })
        } else {
            Alerts.showInfoAlert(viewController: self, title: "Missing Fields", message: "Enter all required fields")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

protocol AddPostViewControllerDelegate: AnyObject {
    func addPostViewController(_ viewController: AddPostViewController, didAdd post: Post)
}
