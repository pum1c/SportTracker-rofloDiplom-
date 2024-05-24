//
//  MainMenuRouter.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation

protocol MainMenuRouter {

    var viewController: MainMenuViewController? { get set }
    func openEditController()

}
    
final class MainMenuRouterImpl: MainMenuRouter {

    weak var viewController: MainMenuViewController?

    func openEditController() {
        guard let navigationController = viewController?.navigationController else { return }

        navigationController.pushViewController(EditerViewController(), animated: true)
    }
}

