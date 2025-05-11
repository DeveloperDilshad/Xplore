//
//  FavouritesViewController.swift
//  Xplore
//
//  Created by Dilshad P on 07/05/25.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouritesTableViewCell.self, forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let mock:[Place] = [
        Place(name: "abs", category: "123", inageURL: "", docID: 0, placeID: "1"),
        Place(name: "abs", category: "123", inageURL: "", docID: 0, placeID: "1"),
        Place(name: "abs", category: "123", inageURL: "", docID: 0, placeID: "1"),
    ]
    
    let favouritePlaces = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureUI()
        
    }
    
    private func configureUI(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

extension FavouritesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as? FavouritesTableViewCell else {return UITableViewCell()}
        cell.configure(with: mock[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    FavouritesViewController()
}
