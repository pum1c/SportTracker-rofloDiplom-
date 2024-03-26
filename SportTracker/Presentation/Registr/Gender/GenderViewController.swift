//
//  GenderViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 21.01.2024.
//

import Foundation
import UIKit
import SnapKit

class GenderViewController: UIViewController {
    
    var selectedButton: UIButton?
    
    let genderLebel = UILabel()
    let cont = UIView()
    let male = UIButton()
    let female = UIButton()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    private func setup() {
        setupBack()
        setupGenderChoose()
        setupContainer()
        setupGenderPick()
        setupButton()
    }
    
    private func setupBack() {
        let backgroundImage = UIImage(named: "Fone")
        let background = UIImageView(image: backgroundImage)
        
        background.contentMode = .scaleToFill
        
        view.addSubview(background)
        
        background.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func setupGenderChoose() {
        genderLebel.text = "Выберите ваш пол"
        genderLebel.textAlignment = .center
        genderLebel.font = .systemFont(ofSize: 36)
        
        view.addSubview(genderLebel)
        
        genderLebel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(190)
        }
    }
    
    private func setupContainer() {
        cont.backgroundColor = .none
        
        view.addSubview(cont)
        
        cont.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(118)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupGenderPick() {
        female.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        female.layer.cornerRadius = 15
        female.setImage(UIImage(named: "female"), for: .normal)
        female.titleLabel?.textAlignment = .center
        female.imageView?.contentMode = .scaleAspectFit
        female.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        
        male.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        male.layer.cornerRadius = 15
        male.setImage(UIImage(named: "male"), for: .normal)
        male.titleLabel?.textAlignment = .center
        male.imageView?.contentMode = .scaleAspectFit
        male.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)

        cont.addSubview(female)
        
        female.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(118)
            
        }
        
        cont.addSubview(male)
        
        male.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(118)
        }
    }
    
    @objc func genderButtonTapped(_ sender: UIButton) {
        selectedButton?.isSelected = false
        selectedButton?.layer.borderWidth = 0
        
        sender.isSelected = true
        sender.layer.borderColor = UIColor.white.cgColor
        sender.layer.borderWidth = 2
        selectedButton = sender
        
        if selectedButton != nil {
            button.backgroundColor = .white
            button.isEnabled = true
        } else {
            button.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
            button.isEnabled = false
        }
    }
    
    private func setupButton() {
        button.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(switchController), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(205)
            make.centerX.equalToSuperview()
            make.height.equalTo(49)
            make.bottom.equalToSuperview().offset(-61)
        }
    }
    
    @objc func switchController() {
        guard selectedButton != nil else {
            print("Выберите ваш пол")
            return
        }
        
        UIView.transition(with: view.window!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            // Выполняем переход на второй ViewController
            self.navigationController?.pushViewController(SportExpViewController(), animated: false)
        },
                          completion: nil)}
}
