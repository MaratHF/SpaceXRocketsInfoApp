//
//  LaunchInfoCell.swift
//  SpaceXRocketsInfoApp
//
//  Created by MAC  on 13.04.2022.
//

import UIKit

class LaunchInfoCell: UICollectionViewCell {
    
    @IBOutlet var nameOfLaunchLabel: UILabel!
    @IBOutlet var statusLaunchImage: UIImageView!
    
    func configure(with launch: Launch) {
        nameOfLaunchLabel.text = """
\(launch.name)
\(Helper.shared.getDate(launch.dateUtc))
"""
        if launch.success == true {
            statusLaunchImage.image = UIImage(named: "success")
        } else {
            statusLaunchImage.image = UIImage(named: "fail")
        }
    }
}
