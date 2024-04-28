//
//  AuthViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 31.01.2024.
//

import Foundation
import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    let fbManager = FirebaseManager()
    
    let nameLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let notWithUsButton = UIButton()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    private func setup() {
        setupBack()
        setupAuthLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupNotWithUsButton()
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
    
    private func setupAuthLabel() {
        nameLabel.text = "Авторизация"
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 36)
        
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(190)
        }
    }
    
    private func setupEmailTextField() {
        emailTextField.layer.cornerRadius = 15
        emailTextField.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        emailTextField.placeholder = "Email"
        emailTextField.font = .systemFont(ofSize: 20)
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(288)
            make.centerX.equalToSuperview()
            make.height.equalTo(59)
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
        }
    }
    
    private func setupPasswordTextField() {
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = .systemFont(ofSize: 20)
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(288)
            make.centerX.equalToSuperview()
            make.height.equalTo(59)
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
        }
    }
    
    private func setupNotWithUsButton() {
        notWithUsButton.backgroundColor = .none
        notWithUsButton.setTitle("Ещё не с нами ?", for: .normal)
        notWithUsButton.setTitleColor(.white, for: .normal)
        notWithUsButton.addTarget(self, action: #selector(switchToRegister), for: .touchUpInside)
        
        view.addSubview(notWithUsButton)
        
        notWithUsButton.snp.makeConstraints { make in
            make.width.equalTo(288)
            make.centerX.equalToSuperview()
            make.height.equalTo(59)
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
        }
    }
    
    private func setupButton() {
        button.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        button.setTitle("Далее", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.addTarget(self, action: #selector(checkLogin), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(205)
            make.centerX.equalToSuperview()
            make.height.equalTo(49)
            make.bottom.equalToSuperview().offset(-61)
        }
    }
    
    @objc private func switchToRegister() {
        UIView.transition(with: view.window!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
                              // Выполняем переход на второй ViewController
                              self.navigationController?.pushViewController(NameViewController(), animated: false)
                          },
                          completion: nil)}
    
    @objc private func checkLogin() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            fbManager.loginUser(email: email, password: password) { [self] userId in
                if let userId = userId {
                    emailTextField.layer.borderWidth = 1
                    emailTextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                    passwordTextField.layer.borderWidth = 1
                    passwordTextField.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                    
                    print("Пользователь успешно аутентифицирован. UID: \(userId)")
                    DispatchQueue.main.async {
                        UIView.transition(with: self.view.window!,
                                          duration: 0.2,
                                          options: .transitionCrossDissolve,
                                          animations: {
                            let mainMenuFactory: MainMenuFactory = MainMenuFactoryImpl()
                            self.navigationController?.pushViewController(mainMenuFactory.makeMainMenuViewController(userId: userId), animated: true)
                            
                        },
                                          completion: nil) }
                } else {
                    emailTextField.text = ""
                    emailTextField.layer.borderWidth = 1
                    emailTextField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                    passwordTextField.text = ""
                    passwordTextField.layer.borderWidth = 1
                    passwordTextField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

                    print("Ошибка аутентификации пользователя.")
                }
            }
        } else {
            print("Введите корректные данные")
        }
    }
}

