//
//  MainMenuViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation
import UIKit
import SnapKit

protocol MainMenuDisplayLogic: AnyObject {}

class MainMenuViewController: UIViewController {
    
    var interactor: MainMenuBusinessLogic?
    
    let db = APIManager()
    let userId: String
        
    init(userId: String) {
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = userId
        
        db.getUserData(userID: userId) { userData, error in
            if let error = error {
                print("Ошибка при получении данных пользователя: \(error.localizedDescription)")
            } else if let userData = userData {
                print("Данные пользователя: \(userData)")
            } else {
                print("Данные пользователя не найдены.")
            }
        }
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
}

extension MainMenuViewController: MainMenuDisplayLogic {}
