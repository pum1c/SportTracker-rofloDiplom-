//
//  SportExpNextViewController().swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 02.02.2024.
//

import Foundation
import UIKit
import SnapKit

class SportExpNextViewController: UIViewController {

    let SportExpNextLebel = UILabel()

    var selectedButton: UIButton?
    var selectedExpNext: String = ""

    let newButton = UIButton()
    let mediumButton = UIButton()
    let profButton = UIButton()

    let button = UIButton()

    let heigh = 41
    let width = 197

    var receivedData: [String:Any?]
    var newUser: UserData
    
    init(data: Any?, newUser: UserData) {
        self.receivedData = data as! [String : Any?]
        self.newUser = newUser
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }

    private func setup() {
        setupBack()
        setupExpQua()
        setupNewButton()
        setupMediumButton()
        setupProfButton()
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

    private func setupExpQua() {
        SportExpNextLebel.text = "На каком уровне ?"
        SportExpNextLebel.textAlignment = .center
        SportExpNextLebel.font = .systemFont(ofSize: 36)
        SportExpNextLebel.numberOfLines = 2
        
        view.addSubview(SportExpNextLebel)
        
        SportExpNextLebel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(150)
        }
    }

    private func setupNewButton() {
        newButton.layer.cornerRadius = 25
        newButton.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        newButton.setTitle("Новичок", for: .normal)
        newButton.titleLabel?.font = .systemFont(ofSize: 14)
        newButton.setTitleColor(UIColor.black, for: .normal)
        newButton.restorationIdentifier = "new"
        newButton.addTarget(self, action: #selector(expButtonTapped(_:)), for: .touchUpInside)

        view.addSubview(newButton)

        newButton.snp.makeConstraints { make in
            make.top.equalTo(SportExpNextLebel.snp.bottom).offset(50)
            make.width.equalTo(width)
            make.height.equalTo(heigh)
            make.centerX.equalToSuperview()
        }
    }

    private func setupMediumButton() {
        mediumButton.layer.cornerRadius = 25
        mediumButton.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        mediumButton.setTitle("Любитель", for: .normal)
        mediumButton.titleLabel?.font = .systemFont(ofSize: 14)
        mediumButton.setTitleColor(UIColor.black, for: .normal)
        mediumButton.restorationIdentifier = "medium"
        mediumButton.addTarget(self, action: #selector(expButtonTapped(_:)), for: .touchUpInside)

        view.addSubview(mediumButton)
        
        mediumButton.snp.makeConstraints { make in
            make.top.equalTo(newButton.snp.bottom).offset(15)
            make.width.equalTo(width)
            make.height.equalTo(heigh)
            make.centerX.equalToSuperview()
        }
    }

    private func setupProfButton() {
        profButton.layer.cornerRadius = 25
        profButton.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        profButton.setTitle("Проффесионал", for: .normal)
        profButton.titleLabel?.font = .systemFont(ofSize: 14)
        profButton.setTitleColor(UIColor.black, for: .normal)
        profButton.restorationIdentifier = "prof"
        profButton.addTarget(self, action: #selector(expButtonTapped(_:)), for: .touchUpInside)

        view.addSubview(profButton)
        
        profButton.snp.makeConstraints { make in
            make.top.equalTo(mediumButton.snp.bottom).offset(15)
            make.width.equalTo(width)
            make.height.equalTo(heigh)
            make.centerX.equalToSuperview()
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

    @objc func expButtonTapped(_ sender: UIButton) {
        selectedButton?.isSelected = false
        selectedButton?.layer.borderWidth = 0
        
        sender.isSelected = true
        sender.layer.borderColor = UIColor.white.cgColor
        sender.layer.borderWidth = 2
        selectedButton = sender
        
        if let selectedTitle = sender.restorationIdentifier {
            selectedExpNext = selectedTitle
                print("Выбран пол: \(selectedExpNext)")
                
                if selectedExpNext == "new" {
                    selectedExpNext = "new"
                } else if selectedExpNext == "meduim" {
                    selectedExpNext = "medium"
                } else if selectedExpNext == "prof" {
                    selectedExpNext = "prof"
                }
            }
        
        if selectedButton != nil {
            button.backgroundColor = .white
            button.isEnabled = true
        } else {
            button.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
            button.isEnabled = false
        }
    }

    @objc func switchController() {
        
        receivedData["sportExpNext"] = selectedExpNext
        
        UIView.transition(with: view.window!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            // Выполняем переход на второй ViewController
            self.navigationController?.pushViewController(PreferenceViewController(data: self.receivedData, newUser: self.newUser), animated: false)
        },
                          completion: nil)}

}
