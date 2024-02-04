//
//  DetailImageViewCell.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import UIKit
import Kingfisher

struct DetailImageViewModel {
    let url: String
}

final class DetailImageViewCell: UITableViewCell {
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    // MARK: - Lifecycle -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
    // MARK: - Private methods -
    private func configureView() {
        contentView.addSubview(posterImageView)
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    // MARK: - Public methods -
    func configure(viewModel: DetailImageViewModel) {
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        let url = URL(string: viewModel.url)
        posterImageView.kf.setImage(with: url)
    }
}
