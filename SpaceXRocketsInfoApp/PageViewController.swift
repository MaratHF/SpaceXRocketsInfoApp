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
    
    func showViewControllerAtIndex(_ index: Int) -> RocketInfoViewController? {
        
        guard index >= 0 else { return nil }
        guard index < rockets.count else { return nil }
        guard let contentViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? RocketInfoViewController else { return nil }
        
        contentViewController.image = rockets[index].flickrImages.randomElement() ?? ""
        contentViewController.rocketName = rockets[index].name
        contentViewController.currentPage = index
        contentViewController.numberOfPages = rockets.count
        contentViewController.rocketDescription = """
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
        
        for launch in launches {
            if launch.rocket == rockets[index].id {
                contentViewController.launches.append(launch)
            }
        }
        
        return contentViewController
    }
}

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
