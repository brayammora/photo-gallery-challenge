//
//  HomeViewController.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 2/02/24.
//

import UIKit

final class HomeViewController: UIViewController {
    var presenter: HomePresenterInterface?
    
    // MARK: - Private properties -
    private lazy var deleteAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(presenter?.deleteButtonText, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CollectionViewHorizontalCustom()
        layout.height = 200
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: PhotoViewCell.name)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter?.title
        setNavigationBarColor()
        configureConstraints()
        presenter?.getNextPage()
    }
    
    // MARK: - Private methods -
    private func configureConstraints() {
        view.addSubview(deleteAllButton)
        view.addSubview(collectionView)
        let constraints = [
            deleteAllButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            deleteAllButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            
            collectionView.topAnchor.constraint(equalTo: deleteAllButton.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -4)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions -
    @objc func deleteAction(sender: UIButton!) {
        presenter?.deleteAllLocalRecords()
    }
}

// MARK: - HomeViewInterface -
extension HomeViewController: HomeViewInterface {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didGetError(_ message: String) {
        DispatchQueue.main.async {
            self.collectionView.setEmptyMessage(message)
        }
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.showLoading()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.hideLoading()
        }
    }
}

// MARK: - UICollectionViewDataSource -
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = presenter?.getItem(at: indexPath),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoViewCell.name, for: indexPath) as? PhotoViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate -
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let presenter = presenter else { return }
        if indexPath.item == presenter.numberOfItems - 1 {
            presenter.getNextPage()
        }
    }
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.sizeToFit()
        backgroundView = messageLabel
    }
    
}
