//
//  SportExpViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 02.02.2024.
//


import Foundation
import UIKit
import SnapKit

class SportExpViewController: UIViewController {
    
    var selectedButton: UIButton?
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
    
    let genderLebel = UILabel()
    let cont = UIView()
    let ye = UIButton()
    let no = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    private func setup() {
        setupBack()
        setupExpQua()
        setupContainer()
        setupGenderPick()
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
        genderLebel.text = "Вы занимались раньше спортом ?"
        genderLebel.textAlignment = .center
        genderLebel.font = .systemFont(ofSize: 36)
        genderLebel.numberOfLines = 2
        
        view.addSubview(genderLebel)
        
        genderLebel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(120)
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
        ye.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        ye.layer.cornerRadius = 15
        ye.setTitle("Да", for: .normal)
        ye.titleLabel?.textAlignment = .center
        ye.imageView?.contentMode = .scaleAspectFit
        ye.addTarget(self, action: #selector(yesPick), for: .touchUpInside)
        
        no.backgroundColor = #colorLiteral(red: 0.4741510749, green: 0.5755669475, blue: 0.9479667544, alpha: 1)
        no.layer.cornerRadius = 15
        no.setTitle("Нет", for: .normal)
        no.titleLabel?.textAlignment = .center
        no.imageView?.contentMode = .scaleAspectFit
        no.addTarget(self, action: #selector(noPick), for: .touchUpInside)
        
        cont.addSubview(ye)
        
        ye.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(118)
            
        }
        
        cont.addSubview(no)
        
        no.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalTo(118)
        }
    }
    
    @objc func yesPick() {
        receivedData["sportExp"] = "yes"
        UIView.transition(with: view.window!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            // Выполняем переход на второй ViewController
            self.navigationController?.pushViewController(SportExpNextViewController(data:self.receivedData, newUser: self.newUser), animated: false)
        },
                          completion: nil)
    }
    
    @objc func noPick() {
        receivedData["sportExp"] = "no"
        UIView.transition(with: view.window!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            // Выполняем переход на второй ViewController
            self.navigationController?.pushViewController(PreferenceViewController(data:self.receivedData, newUser: self.newUser), animated: false)
        },
                          completion: nil)
    }
}
