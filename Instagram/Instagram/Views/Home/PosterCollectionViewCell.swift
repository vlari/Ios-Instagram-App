//
//  PosterCollectionViewCell.swift
//  Instagram
//
//  Created by Obed Garcia on 3/11/21.
//

import UIKit
import SDWebImage

protocol PosterCollectionViewCellDelegate: AnyObject {
    func posterCollectionViewCellDidTapMore(_ cell: PosterCollectionViewCell, index: Int)
    func posterCollectionViewCellDidTapUsername(_ cell: PosterCollectionViewCell, index: Int)
}

class PosterCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PosterCollectionViewCell.self)
    private var index = 0
    weak var delegate: PosterCollectionViewCellDelegate?
    private let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    private let nameLabel: UILabel = {
       let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .regular)
        return nameLabel
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "ellipsis",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMore), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didTapUsername))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height - 4
        imageView.frame = CGRect(x: 2, y: 2, width: imageSize, height: imageSize)
        imageView.layer.cornerRadius = imageSize / 2
        
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(
            x: imageView.right+10,
            y: 0,
            width: nameLabel.width,
            height: contentView.height
        )

        moreButton.frame = CGRect(x: contentView.width-55,
                                  y: (contentView.height-50)/2,
                                  width: 50,
                                  height: 50)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        imageView.image = nil
    }
    
    func configure(with viewModel: PosterCollectionViewCellViewModel, index: Int) {
        self.index = index
        nameLabel.text = viewModel.username
        imageView.sd_setImage(with: viewModel.profilePictureURL, completed: nil)
    }
    
    @objc func didTapUsername() {
        delegate?.posterCollectionViewCellDidTapUsername(self, index: index)
    }

    @objc func didTapMore() {
        delegate?.posterCollectionViewCellDidTapMore(self, index: index)
    }
}
