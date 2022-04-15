//
//  LauchesViewController.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 13.04.2022.
//

import UIKit

class LaunchesViewController: UICollectionViewController {
    
    var launches: [Launch] = []
    var rocketName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.view.backgroundColor = .black
        navigationItem.title = rocketName
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: false)
    }
}

// MARK: - UICollectionViewDataSource
extension LaunchesViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !launches.isEmpty {
            return launches.count
        } else {
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LaunchInfoCell
        
        if !launches.isEmpty {
            cell.configure(with: launches[indexPath.item])
        } else {
            cell.nameOfLaunchLabel.text = "Данные о запусках отсутствуют"
            cell.statusLaunchImage.image = UIImage(named: "emoji")
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
