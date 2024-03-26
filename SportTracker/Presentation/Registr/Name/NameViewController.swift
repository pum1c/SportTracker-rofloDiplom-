//
//  NameViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 31.12.2023.
//

import UIKit
import SnapKit

protocol NameDisplayLogic: AnyObject {
    
}

final class NameViewController: UIViewController {
    
    // MARK: - Public properties
    
    let fbManager = FirebaseManager()
    let db = APIManager()
    
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    private func setup() {
        setupBack()
        setupNameQuation()
        setuptextField()
        setupButton()
        setupEmailTextField()
        setupPasswordTextField()
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
    
    private func setupNameQuation() {
        nameLabel.text = "Регистрация"
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 36)
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalToSuperview().offset(190)
        }
    }
    
    private func setuptextField() {
        nameTextField.layer.cornerRadius = 15
        nameTextField.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        nameTextField.placeholder = "Имя"
        nameTextField.font = .systemFont(ofSize: 20)
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftViewMode = .always
        nameTextField.delegate = self
        
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.width.equalTo(288)
            make.centerX.equalToSuperview()
            make.height.equalTo(59)
            make.top.equalTo(nameLabel.snp.bottom).offset(78)
        }
    }
    
    private func setupEmailTextField() {
        emailTextField.layer.cornerRadius = 15
        emailTextField.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        emailTextField.placeholder = "Email"
        emailTextField.font = .systemFont(ofSize: 20)
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        emailTextField.delegate = self
        
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(288)
            make.centerX.equalToSuperview()
            make.height.equalTo(59)
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
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
        passwordTextField.delegate = self
        
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(288)
            make.centerX.equalToSuperview()
            make.height.equalTo(59)
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
        }
    }
    
    private func setupButton() {
        button.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
        button.setTitle("Далее", for: .normal)
        button.addTarget(self, action: #selector(switchController), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        button.isEnabled = false
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(205)
            make.centerX.equalToSuperview()
            make.height.equalTo(49)
            make.bottom.equalToSuperview().offset(-61)
        }
    }
    
    @objc func switchController() {
        // Создаем нового пользователя
        let newUser = UserData(email: emailTextField.text!, name: nameTextField.text!, password: passwordTextField.text!)

        // Регистрируем нового пользователя
        fbManager.registNewUser(user: newUser) { receivedUserID, error in
            if let error = error {
                print("Ошибка при регистрации нового пользователя: \(error.localizedDescription)")
            } else if let receivedUserID = receivedUserID {
                // Подготавливаем данные для сохранения в Firestore
                let dataToSend: [String:Any] = [
                    "name": self.nameTextField.text!,
                    "mail": self.emailTextField.text!
                ]

                // Отправляем данные в Firestore, используя полученный userID
                self.db.sendDataToFirestore(collection: "date", userID: receivedUserID, data: dataToSend) { error in
                    if let error = error {
                        print("Ошибка при отправке данных: \(error.localizedDescription)")
                    } else {
                        print("Данные успешно отправлены в Firestore!")
                        
                        // Переходим на следующий экран
                        DispatchQueue.main.async {
                            UIView.transition(with: self.view.window!,
                                              duration: 1.0,
                                              options: .transitionCrossDissolve,
                                              animations: {
                                                  self.navigationController?.pushViewController(GenderViewController(), animated: false)
                                              },
                                              completion: nil)
                        }
                    }
                }
            }
        }
    }
}

extension NameViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if nameTextField.text?.isEmpty ?? true || emailTextField.text?.isEmpty ?? true || passwordTextField.text?.isEmpty ?? true {
            button.backgroundColor = #colorLiteral(red: 0.4690825343, green: 0.5757023692, blue: 0.9521482587, alpha: 1)
            button.isEnabled = false
        } else {
            button.backgroundColor = .white
            button.isEnabled = true
        }
    }
}

