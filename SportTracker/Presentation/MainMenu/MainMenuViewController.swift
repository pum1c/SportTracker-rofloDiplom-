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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
}

extension MainMenuViewController: MainMenuDisplayLogic {}
