//
//  PostCell.swift
//

import UIKit

class PostCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: - Properties
    private(set) var viewModel: PostCellViewModel?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setSelectionColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCellInnerSpacing()
    }
    
    // MARK: - Methods
    private func setSelectionColor() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        selectedBackgroundView = backgroundView
    }
    
    private func setCellInnerSpacing() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    func setup(viewModel: PostCellViewModel) {
        self.viewModel = viewModel
        
        guard let post = viewModel.post else {
            return
        }
        
        // display title
        titleLabel.text = post.title ?? "Unknown"
        
        // display subtitle
        subtitleLabel.text = post.body ?? "--"
    }
    
    // MARK: - Actions
    
}
