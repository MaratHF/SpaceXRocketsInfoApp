//
//  FirstViewController.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 13.04.2022.
//

import UIKit

class StartViewController: UIViewController {

    private var launches: [Launch] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchLaunches()
       
    }
    
    private func fetchLaunches() {
        NetworkManager.shared.fetch(dataType: [Launch].self, from: Link.launchesURL.rawValue) { result in
            switch result {
            case .success(let launches):
                self.launches = launches
                self.startRocketsInfo()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func startRocketsInfo() {
        if let pageViewController = storyboard?.instantiateViewController(
            withIdentifier: "PageViewController") as? PageViewController {
            pageViewController.launches = launches
            
            present(pageViewController, animated: false)
        }
    }
}
