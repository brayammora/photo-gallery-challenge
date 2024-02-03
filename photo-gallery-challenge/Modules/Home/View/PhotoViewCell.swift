//
//  PhotoViewCell.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import UIKit

struct PhotoViewModel {
    let title: String
    let thumbnailUrl: String
}

final class PhotoViewCell: UICollectionViewCell {
    
    // MARK: - Private properties -
    private let photoTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // MARK: - Lifecycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoTitle.text = ""
        thumbnailImageView.image = nil
    }
    
    // MARK: - Private methods -
    private func configureView() {
        contentView.addSubview(photoTitle)
        contentView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            photoTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            thumbnailImageView.topAnchor.constraint(equalTo: photoTitle.bottomAnchor, constant: 8),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Public methods -
    func configure(with model: PhotoViewModel) {
        photoTitle.text = model.title
        thumbnailImageView.downloadImage(from: model.thumbnailUrl)
    }
}
