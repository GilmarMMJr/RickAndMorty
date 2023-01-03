//
//  RMTabBarViewController.swift
//  RickAndMorty
//
//  Created by Gilmar Junior on 02/01/23.
//

import UIKit

/// Controlador para abrigar tabs e root tab controllers
final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let charactersVC = RMCharacterViewController()
        let locationsVC = RMLocationViewController()
        let episodesVC = RMEpisodeViewController()
        let settingsVC = RMSettingsViewController()
        
        charactersVC.navigationItem.largeTitleDisplayMode = .automatic
        locationsVC.navigationItem.largeTitleDisplayMode = .automatic
        episodesVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav0 = UINavigationController(rootViewController: charactersVC)
        let nav1 = UINavigationController(rootViewController: locationsVC)
        let nav2 = UINavigationController(rootViewController: episodesVC)
        let nav3 = UINavigationController(rootViewController: settingsVC)
        
        nav0.tabBarItem = UITabBarItem(title: "Characters",
                                       image: UIImage(systemName: "person"),
                                       tag: 0)
        nav1.tabBarItem = UITabBarItem(title: "Locations",
                                       image: UIImage(systemName: "globe"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Episodes",
                                       image: UIImage(systemName: "tv"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gear"),
                                       tag: 3)
        
        for nav in [nav0, nav1, nav2, nav3] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav0, nav1, nav2, nav3],
            animated: true
        )
        
    }


}

