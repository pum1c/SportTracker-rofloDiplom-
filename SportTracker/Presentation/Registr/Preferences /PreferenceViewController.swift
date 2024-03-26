//
//  PreferebcesViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 02.02.2024.
//

import Foundation
import UIKit
import SnapKit

class PreferenceViewController: UIViewController {
    
    let preferencesLabel = UILabel()
    let splitLabel = UILabel()
    let fullBodyLabel = UILabel()
    
    var selectedButton: UIButton?
    let splitButton = UIButton()
    let fullBodyButton = UIButton()
    let button = UIButton()
    
    let cont = UIView()
    
    let labelHight = 64
    let labelWidth = 280
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    
    private func setup() {
        setupBack()
        setupPrefQua()
        setupPreferencesPick()
        setupContainer()
        setupSplitLebel()
        setupFullBodyLebel()
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
    
    private func setupPrefQua() {
        preferencesLabel.text = "Какой вид тренировок предпочитаете ?"
        preferencesLabel.textAlignment = .center
        preferencesLabel.font = .systemFont(ofSize: 36)
        preferencesLabel.numberOfLines = 2
        
        view.addSubview(preferencesLabel)
        
        preferencesLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(150)
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
    
    private func setupPreferencesPick() {
        splitButton.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        splitButton.layer.cornerRadius = 15
        splitButton.setTitle("Сплит", for: .normal)
        splitButton.titleLabel?.textAlignment = .center
        splitButton.imageView?.contentMode = .scaleAspectFit
        splitButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        fullBodyButton.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        fullBodyButton.layer.cornerRadius = 15
        fullBodyButton.setTitle("Фулл-Бади", for: .normal)
        fullBodyButton.titleLabel?.textAlignment = .center
        fullBodyButton.imageView?.contentMode = .scaleAspectFit
        fullBodyButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        cont.addSubview(splitButton)
        
        splitButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(118)
            
        }
        
        cont.addSubview(fullBodyButton)
        
        fullBodyButton.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(118)
        }
    }
    
    private func setupSplitLebel() {
        splitLabel.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        splitLabel.layer.cornerRadius = 15
        splitLabel.layer.masksToBounds = true
        splitLabel.numberOfLines = 3
        splitLabel.textAlignment = .center
        splitLabel.text = "Сплит - тип тренировки, где вы прорабатываете 1 большую группу мышц за 1 тренировку"
        splitLabel.font = .systemFont(ofSize: 12)
        splitLabel.textColor = .white
        
        view.addSubview(splitLabel)
        
        splitLabel.snp.makeConstraints { make in
            make.height.equalTo(labelHight)
            make.width.equalTo(labelWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(cont.snp.bottom).offset(15)
        }
    }
    
    private func setupFullBodyLebel() {
        fullBodyLabel.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        fullBodyLabel.layer.cornerRadius = 15
        fullBodyLabel.layer.masksToBounds = true
        fullBodyLabel.numberOfLines = 4
        fullBodyLabel.textAlignment = .center
        fullBodyLabel.text = "Фулл-Бади - тип тренировки, где вы прорабатываете все большие группы мышц за одну тренировку, но в меньшем количестве"
        fullBodyLabel.font = .systemFont(ofSize: 12)
        fullBodyLabel.textColor = .white
        
        view.addSubview(fullBodyLabel)
        
        fullBodyLabel.snp.makeConstraints { make in
            make.height.equalTo(labelHight)
            make.width.equalTo(labelWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(splitLabel.snp.bottom).offset(10)
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
    
    @objc func buttonTapped(_ sender: UIButton) {
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
    
    @objc func switchController() {
        UIView.transition(with: view.window!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            // Выполняем переход на второй ViewController
            self.navigationController?.pushViewController(TimeViewController(), animated: false)
        },
                          completion: nil)}
    
}
