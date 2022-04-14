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
        contentViewController.rocketDescription = """
Первый запуск                  \(Helper.shared.getDate(rockets[index].firstFlight))

Страна                         \(rockets[index].country)

Стоимость запуска              \(rockets[index].costPerLaunch)


ПЕРВАЯ СТУПЕНЬ

Количество двигателей          \(rockets[index].firstStage.engines)

Количество топлива             \(rockets[index].firstStage.fuelAmountTons)

Время сгорания                 \(rockets[index].firstStage.burnTimeSec ?? 0)


ВТОРАЯ СТУПЕНЬ

Количество двигателей          \(rockets[index].secondStage.engines)

Количество топлива             \(rockets[index].secondStage.fuelAmountTons)

Время сгорания                 \(rockets[index].secondStage.burnTimeSec ?? 0)
"""
        contentViewController.currentPage = index
        contentViewController.numberOfPages = rockets.count
        
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
