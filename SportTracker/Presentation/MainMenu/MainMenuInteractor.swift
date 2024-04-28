//
//  MainMenuInteractor.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation

protocol MainMenuBusinessLogic: AnyObject {

    func getData(userId: String)
    func dataToPresenter(userData: [String:Any])
}

protocol MainMenuDataSource {}

final class MainMenuInteractor {

    var presenter: MainMenuPresentationLogic?
    
    let db = APIManager()
    var userData: [String:Any]?
        
}

extension MainMenuInteractor: MainMenuBusinessLogic {

    func getData(userId: String) {
        db.getUserData(userID: userId) { [weak self] userData, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Ошибка при получении данных пользователя: \(error.localizedDescription)")
            } else if let userData = userData {
                self.userData = userData
                print("Данные пользователя: \(userData)")
                self.dataToPresenter(userData: userData)
            } else {
                print("Данные пользователя не найдены.")
            }
        }
    }
    
    func dataToPresenter(userData: [String:Any]) {
        presenter?.pullData(userData: userData)
    }
    
}
