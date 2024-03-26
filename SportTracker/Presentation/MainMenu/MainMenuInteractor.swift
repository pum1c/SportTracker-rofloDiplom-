//
//  MainMenuInteractor.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation

protocol MainMenuBusinessLogic: AnyObject {

    func nextButtonTouched(name: String)
}

protocol MainMenuDataSource {}

final class MainMenuInteractor {
    
    var presenter: MainMenuPresentationLogic?
   
}

extension MainMenuInteractor: MainMenuBusinessLogic {
    func nextButtonTouched(name: String) {
        
    }
}
