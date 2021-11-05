//
//  PostDateCollectionViewCell.swift
//  Instagram
//
//  Created by Obed Garcia on 3/11/21.
//

import UIKit

class PostDateCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PostDateCollectionViewCell.self)
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: contentView.width-12, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func configure(with viewModel: PostDateCollectionViewCellViewModel) {
        let date = viewModel.date
        label.text = .date(from: date)
    }
}
