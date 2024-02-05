//
//  DetailButtonViewCell.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 4/02/24.
//

import UIKit

protocol DetailButtonViewCellProtocol: AnyObject {
    func buttonAction()
}

struct DetailButtonViewModel {
    let buttonText: String
}

final class DetailButtonViewCell: UITableViewCell {
    
    private lazy var button: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()

    weak var delegate: DetailButtonViewCellProtocol?
    
    // MARK: - Lifecycle -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private methods -
    private func configureView() {
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Actions -
    @objc private func buttonAction(sender: UIButton!) {
        delegate?.buttonAction()
    }
    
    // MARK: - Public methods -
    func configure(viewModel: DetailButtonViewModel) {
        backgroundColor = .black
        button.setTitle(viewModel.buttonText, for: .normal)
    }
}

