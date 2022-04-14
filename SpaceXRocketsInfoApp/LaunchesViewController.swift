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
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LaunchInfoCell
        
        cell.configure(with: launches[indexPath.item])
    
        return cell
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: false)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
