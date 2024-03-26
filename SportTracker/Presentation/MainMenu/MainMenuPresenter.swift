//
//  MainMenuPresenter.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation

protocol MainMenuPresentationLogic: AnyObject {

}

final class MainMenuPresenter {
    
    weak var viewController: MainMenuDisplayLogic?
    private let router: MainMenuRouter

    init(router: MainMenuRouter) {
        self.router = router
    }
}

extension MainMenuPresenter: MainMenuPresentationLogic {

}
