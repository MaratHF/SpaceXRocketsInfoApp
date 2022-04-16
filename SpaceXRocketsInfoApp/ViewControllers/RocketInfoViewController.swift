//
//  ViewController.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 10.04.2022.
//

import UIKit

class RocketInfoViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var characteristicLabel: CharacteristicsRocketViewCell!
    @IBOutlet var rocketImage: UIImageView!
    @IBOutlet var rocketDescriptionLabel: UILabel!
    @IBOutlet var rocketNameLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var subview: UIView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var rocketDescription = ""
    var rocketName = ""
    var numberOfPages = 0
    var currentPage = 0
    var image = ""
    var launches: [Launch] = []
    var characteristicsValue: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        subview.layer.cornerRadius = 35
        subview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchImage()
        
        rocketNameLabel.text = rocketName
        rocketDescriptionLabel.text = rocketDescription
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: image) { result in
            switch result {
            case .success(let data):
                self.rocketImage.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let launchesVC = navigationVC.topViewController as? LaunchesViewController else { return }
        
        launchesVC.launches = launches
        launchesVC.rocketName = rocketName
    }
}

// MARK: - UICollectionViewDataSource
extension RocketInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characteristicsValue.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rocketCell", for: indexPath) as! CharacteristicsRocketViewCell
        
        let namesOfCharacteristics = ["Высота, м", "Диаметр, м", "Масса, кг", "Нагрузка, кг"]
        
        cell.characteristicValue.text = characteristicsValue[indexPath.item]
        cell.characteristicName.text = namesOfCharacteristics[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RocketInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 128, height: 128)
    }
}
