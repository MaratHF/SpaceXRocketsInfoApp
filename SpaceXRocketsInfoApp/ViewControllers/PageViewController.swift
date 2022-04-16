//
//  PageViewController.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 11.04.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var rockets: [Rocket] = []
    var launches: [Launch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        fetchRockets()
    }
}

// MARK: - Private methods
extension PageViewController {
    private func fetchRockets() {
        NetworkManager.shared.fetch(dataType: [Rocket].self, from: Link.rocketsURL.rawValue) { result in
            switch result {
            case .success(let rockets):
                self.rockets = rockets
    
                if let contentViewController = self.showViewControllerAtIndex(0) {
                    self.setViewControllers([contentViewController], direction: .forward, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showViewControllerAtIndex(_ index: Int) -> RocketInfoViewController? {
        guard index >= 0 else { return nil }
        guard index < rockets.count else { return nil }
        guard let rocketInfoVC = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? RocketInfoViewController else { return nil }
        
        rocketInfoVC.image = rockets[index].flickrImages.randomElement() ?? ""
        rocketInfoVC.rocketName = rockets[index].name
        rocketInfoVC.currentPage = index
        rocketInfoVC.numberOfPages = rockets.count
        rocketInfoVC.rocketDescription = """
\(Helper.shared.getDate(rockets[index].firstFlight))

\(Helper.shared.translateCountry(rockets[index].country))

$\(Double(rockets[index].costPerLaunch) / 1000000) млн




\(rockets[index].firstStage.engines)

\(rockets[index].firstStage.fuelAmountTons) тонн

\(rockets[index].firstStage.burnTimeSec ?? 0) сек




\(rockets[index].secondStage.engines)

\(rockets[index].secondStage.fuelAmountTons) тонн

\(rockets[index].secondStage.burnTimeSec ?? 0) сек
"""
        
        let characteristics = [
            String(rockets[index].height.meters),
            String(rockets[index].diameter.meters),
            String(rockets[index].mass.kg),
            String(rockets[index].payloadWeights.first?.kg ?? 0)
        ]
        
        rocketInfoVC.characteristicsValue = characteristics
        
        for launch in launches {
            if launch.rocket == rockets[index].id {
                rocketInfoVC.launches.append(launch)
            }
        }
        return rocketInfoVC
    }
}

// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! RocketInfoViewController).currentPage
        
        pageNumber -= 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! RocketInfoViewController).currentPage
        
        pageNumber += 1
        
        return showViewControllerAtIndex(pageNumber)
    }
}
