//
//  MainMenuFactory.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation
import UIKit.UIViewController

protocol MainMenuFactory {

    func makeMainMenuViewController() -> UIViewController
}

extension MainMenuFactory {
    
    func makeMainMenuViewController() -> UIViewController {
        let interactor = MainMenuInteractor()
        let viewController = MainMenuViewController()
        var router: MainMenuRouter = MainMenuRouterImpl()
        router.viewController = viewController
        let presenter = MainMenuPresenter(router: router)
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        
        return viewController
    }
}
