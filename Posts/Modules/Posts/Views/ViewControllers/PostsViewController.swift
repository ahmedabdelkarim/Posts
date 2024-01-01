//
//  PostsViewController.swift
//

import UIKit

class PostsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var postsTable: UITableView!
    @IBOutlet weak var emptyStateView: UIView!
    
    // MARK: - Properties
    let viewModel = DependencyRegistry.default.postsViewModelWithOnlineOnly()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePostsTable()
        
        // fix issue of refreshControl.tintColor not changed first time
        if let refreshControl = postsTable.refreshControl {
            postsTable.contentOffset = CGPoint(x: 0, y: -refreshControl.frame.size.height)
        }
        
        loadPosts()
    }
    
    // MARK: - Methods
    func configurePostsTable() {
        postsTable.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        // enable pull refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "AccentColor")
        postsTable.refreshControl = refreshControl
        postsTable.refreshControl?.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        
        postsTable.registerCell(ofType: PostCell.self)
    }
    
    @objc func refreshPosts() {
        loadPosts()
    }
    
    func loadPosts() {
        self.postsTable.refreshControl?.programmaticallyBeginRefreshing(in: postsTable)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.viewModel.getPosts(success: { [weak self] posts in
                DispatchQueue.main.async {
                    self?.postsTable.refreshControl?.endRefreshing()
                    self?.postsTable.reloadData()
                    
                    self?.emptyStateView.isHidden = !posts.isEmpty
                }
            }, failure: { [weak self] error in
                var errorMessage = "An error occurred while loading posts"
                
                if let error = error {
                    errorMessage = error.localizedDescription
                }
                else {
                    print("unknown error while loading posts")
                }
                
                DispatchQueue.main.async {
                    Alerts.showInfoAlert(viewController: self, title: "Error", message: errorMessage) {
                        self?.postsTable.refreshControl?.endRefreshing()
                    }
                }
            })
        }
    }
    
    // MARK: - Actions
    @IBAction func refresh(_ sender: Any) {
        loadPosts()
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTable.dequeueCell() as PostCell
        
        let postCellViewModel = PostCellViewModel(post: viewModel.posts[indexPath.row])
        cell.setup(viewModel: postCellViewModel)
        
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showPostDetails", sender: self)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPostDetails":
            if let vc = segue.destination as? PostDetailsViewController {
                if let selectedIndex = postsTable.indexPathForSelectedRow, viewModel.posts.count > selectedIndex.row {
                    vc.viewModel = PostDetailsViewModel(post: viewModel.posts[selectedIndex.row])
                    
                    postsTable.deselectRow(at: selectedIndex, animated: true)
                }
            }
            else {
                Alerts.showInfoAlert(viewController: self, title: "Error", message: "Couldn't open details")
            }
        case "addPost":
            if let vc = segue.destination as? AddPostViewController {
                vc.viewModel = DependencyRegistry.default.addPostViewModel(postToEdit: nil)
                vc.delegate = self
            }
        default:
            break
        }
    }
}

extension PostsViewController: AddPostViewControllerDelegate {
    func addPostViewController(_ viewController: AddPostViewController, didAdd post: Post) {
        // refresh items
        DispatchQueue.main.async { [weak self] in
            self?.loadPosts()
        }
    }
}


extension UIRefreshControl {
    func programmaticallyBeginRefreshing(in tableView: UITableView) {
        beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -frame.size.height)
        tableView.setContentOffset(offsetPoint, animated: true)
    }
}
