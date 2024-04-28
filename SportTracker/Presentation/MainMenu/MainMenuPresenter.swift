//
//  MainMenuPresenter.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation

protocol MainMenuPresentationLogic: AnyObject {
    func pullData(userData: [String:Any])
}

final class MainMenuPresenter {
    
    weak var viewController: MainMenuDisplayLogic?
    private let router: MainMenuRouter

    init(router: MainMenuRouter) {
        self.router = router
    }
}

extension MainMenuPresenter: MainMenuPresentationLogic {
    
    func pullData(userData: [String:Any]) {
        guard
            let username = userData["name"] as? String,
            let gender = userData["gender"] as? String,
            let sportExp = userData["sportExp"] as? String,
            let sportExpNext = userData["sportExpNext"] as? String,
            let preference = userData["preference"] as? String,
            let time = userData["time"] as? Int
        else {
            return
        }

        viewController?.updateInterfaceWithProcessedData(username: username, gender: gender, sportExp: sportExp, sportExpNext: sportExpNext, preference: preference, time: time)
        }
        
    }

