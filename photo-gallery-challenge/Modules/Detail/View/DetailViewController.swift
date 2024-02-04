//
//  DetailViewController.swift
//  photo-gallery-challenge
//
//  Created by Brayam Mora on 3/02/24.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: DetailPresenterInterface?
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureTableView()
        presenter?.didLoad()
    }
}

// MARK: - Private methods -
private extension DetailViewController {
    private func configureTableView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.register(DetailImageViewCell.self, forCellReuseIdentifier: DetailImageViewCell.name)
        tableView.register(DetailInfoViewCell.self, forCellReuseIdentifier: DetailInfoViewCell.name)
        tableView.register(DetailButtonViewCell.self, forCellReuseIdentifier: DetailButtonViewCell.name)
        tableView.dataSource = self
    }
}

// MARK: - DetailViewInterface -
extension DetailViewController: DetailViewInterface {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource -
extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItemsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section: DetailTableViewSection = presenter?.getItem(at: indexPath) else { return UITableViewCell() }
    
        switch section {
        case .image(let detailImageViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageViewCell.name, for: indexPath) as? DetailImageViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(viewModel: detailImageViewModel)
            return cell
        case .info(let infoViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoViewCell.name, for: indexPath) as? DetailInfoViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(viewModel: infoViewModel)
            return cell
        case .deleteButtton(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailButtonViewCell.name, for: indexPath) as? DetailButtonViewCell
            else {
                return UITableViewCell()
            }
            cell.configure(viewModel: model)
            return cell
        }
    }
}
