//
//  MainMenuRouter.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation

protocol MainMenuRouter {

    var viewController: MainMenuViewController? { get set }

}
    
final class MainMenuRouterImpl: MainMenuRouter {

    weak var viewController: MainMenuViewController?

    func openBirthdayDate(name: String) {
        guard let navigationController = viewController?.navigationController else { return }

        //navigationController.pushViewController(birthdayDateFactory.makeBirthdayDateViewController(name: name), animated: true)
    }
}
