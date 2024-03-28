//
//  TimeViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 13.03.2024.
//

import Foundation
import UIKit
import SnapKit

class TimeViewController: UIViewController {
    
    let fbManager = FirebaseManager()
    let db = APIManager()
    
    
    let timeLabel = UILabel()
    
    let oneButton = UIButton()
    let twoButton = UIButton()
    let threeButton = UIButton()
    
    var selectedButton: UIButton?
    var selectedTime: String = ""
    var time = 0
    
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
        setupTimeQua()
        setupOneHour()
        setupTwoHour()
        setupThreeHour()
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
    
    private func setupTimeQua() {
        timeLabel.text = "Сколько времени вы готовы уделять на тренировку ?"
        timeLabel.textAlignment = .center
        timeLabel.font = .systemFont(ofSize: 30)
        timeLabel.numberOfLines = 3
        
        view.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(150)
        }
    }
    
    private func setupOneHour() {
        oneButton.layer.cornerRadius = 25
        oneButton.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        oneButton.setTitle("1 час", for: .normal)
        oneButton.titleLabel?.font = .systemFont(ofSize: 14)
        oneButton.setTitleColor(UIColor.black, for: .normal)
        oneButton.restorationIdentifier = "1"
        oneButton.addTarget(self, action: #selector(expButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(oneButton)
        
        oneButton.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(50)
            make.width.equalTo(width)
            make.height.equalTo(heigh)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupTwoHour() {
        twoButton.layer.cornerRadius = 25
        twoButton.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        twoButton.setTitle("2 часа", for: .normal)
        twoButton.titleLabel?.font = .systemFont(ofSize: 14)
        twoButton.setTitleColor(UIColor.black, for: .normal)
        twoButton.restorationIdentifier = "2"
        twoButton.addTarget(self, action: #selector(expButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(twoButton)
        
        twoButton.snp.makeConstraints { make in
            make.top.equalTo(oneButton.snp.bottom).offset(15)
            make.width.equalTo(width)
            make.height.equalTo(heigh)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupThreeHour() {
        threeButton.layer.cornerRadius = 25
        threeButton.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        threeButton.setTitle("3 часа", for: .normal)
        threeButton.titleLabel?.font = .systemFont(ofSize: 14)
        threeButton.setTitleColor(UIColor.black, for: .normal)
        threeButton.restorationIdentifier = "3"
        threeButton.addTarget(self, action: #selector(expButtonTapped(_:)), for: .touchUpInside)
        
        view.addSubview(threeButton)
        
        threeButton.snp.makeConstraints { make in
            make.top.equalTo(twoButton.snp.bottom).offset(15)
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
            selectedTime = selectedTitle
            
            if selectedTime == "1" {
                time = 1
            } else if selectedTime == "2" {
                time = 2
            } else if selectedTime == "3" {
                time = 3
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
        // Подготовка данных для сохранения в Firestore
        receivedData["time"] = time
        
        // Регистрация нового пользователя
        fbManager.registNewUser(user: newUser) { receivedUserID, error in
            if let error = error {
                print("Ошибка при регистрации нового пользователя: \(error.localizedDescription)")
            } else if let receivedUserID = receivedUserID {
                // Отправка данных в Firestore, используя полученный userID
                self.db.sendDataToFirestore(collection: "date", userID: receivedUserID, data: self.receivedData) { error in
                    if let error = error {
                        print("Ошибка при отправке данных: \(error.localizedDescription)")
                    } else {
                        print("Данные успешно отправлены в Firestore!")
                        
                        // Переход на следующий ViewController после успешной отправки данных
                        UIView.transition(with: self.view.window!,
                                          duration: 1.0,
                                          options: .transitionCrossDissolve,
                                          animations: {
                            // Создаем экземпляр фабрики главного меню
                            let mainMenuFactory: MainMenuFactory = MainMenuFactoryImpl()
                            // Создаем и показываем главное меню
                            self.navigationController!.pushViewController(mainMenuFactory.makeMainMenuViewController(userId: receivedUserID), animated: true)
                        },
                                          completion: nil)
                    }
                }
            }
        }
    }
}
