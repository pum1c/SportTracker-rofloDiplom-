//
//  MainMenuViewController.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 20.03.2024.
//

import Foundation
import UIKit
import SnapKit

protocol MainMenuDisplayLogic: AnyObject {
    
    func dataToInteractor()
    func updateInterfaceWithProcessedData(username: String, gender: String, sportExp: String, sportExpNext: String, preference: String, time: Int)
}

protocol SegmentControlDelegate: AnyObject {
    func segmentControlDidChange(selectedIndex: Int)
}

final class MainMenuViewController: UIViewController {
    
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
    
    let helloLabel = UILabel()
    
    let editButton = UIButton()
    let segmentControl = UISegmentedControl(items: ["Тренировка", "Диета"])
    
    let trainConteinerView = UIView()
    let trainLabel = UILabel()
    let firstExsButton = UIButton()
    let secondExsButton = UIButton()
    let thirdExsButton = UIButton()
    let fourthExsButton = UIButton()
    let fifthExsButton = UIButton()
    
    let buttonHeight = 48
    let buttonWidth = 280
    let buttonColor = #colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1)
    
    let completedButton = UIButton()
    
    let dietLabel = UILabel()
    let inputTextField = UITextField()
    let addButton = UIButton()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = userId
        view.backgroundColor = .white
        
        setup()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
    }
    
    func setup() {
        dataToInteractor()
        setupHelloLabel()
        setupSegmentControl()
        setupEditButton()
        setupTrainContainer()
        setupCompleatedButton()
        setupDietLabel()
        setupStackView()
        setupInputTextField()
        setupAddButton()
    }
    
    func setupHelloLabel() {
        helloLabel.textColor = .black
        helloLabel.textAlignment = .center
        helloLabel.font = .systemFont(ofSize: 20)
        
        view.addSubview(helloLabel)
        
        helloLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
    }
    
    func setupEditButton() {
        let editImage = UIImage(named: "editer")
        editButton.setImage(editImage, for: .normal)
        editButton.addTarget(self, action: #selector(switchToEditController), for: .touchUpInside)
        
        view.addSubview(editButton)
        
        editButton.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(100)
        }
    }
    
    func setupSegmentControl() {
        segmentControl.selectedSegmentTintColor = UIColor.white
        segmentControl.backgroundColor = #colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.layer.borderWidth = 1
        segmentControl.layer.cornerRadius = 30
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(segmentControl)
        
        segmentControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(helloLabel.snp.bottom).offset(35)
            make.width.equalTo(237)
            make.height.equalTo(27)
        }
    }
    
    func setupTrainContainer() {
        trainConteinerView.backgroundColor = #colorLiteral(red: 0.9019607902, green: 0.9019607902, blue: 0.9019607902, alpha: 1)
        trainConteinerView.layer.cornerRadius = 20
        
        view.addSubview(trainConteinerView)
        
        trainConteinerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(segmentControl.snp.bottom).offset(80)
            make.height.equalTo(370)
            make.width.equalTo(316)
        }
        
        trainLabel.text = ""
        trainLabel.textAlignment = .left
        trainLabel.font = .systemFont(ofSize: 20)
        
        trainConteinerView.addSubview(trainLabel)
        
        trainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        firstExsButton.backgroundColor = buttonColor
        firstExsButton.layer.cornerRadius = 20
        firstExsButton.setTitle("Отжимания от пола", for: .normal)
        firstExsButton.setTitleColor(.black, for: .normal)
        
        secondExsButton.backgroundColor = buttonColor
        secondExsButton.layer.cornerRadius = 20
        secondExsButton.setTitle("Отжимания от брусьев", for: .normal)
        secondExsButton.setTitleColor(.black, for: .normal)
        
        thirdExsButton.backgroundColor = buttonColor
        thirdExsButton.layer.cornerRadius = 20
        thirdExsButton.setTitle("Жим гантелей", for: .normal)
        thirdExsButton.setTitleColor(.black, for: .normal)
        
        fourthExsButton.backgroundColor = buttonColor
        fourthExsButton.layer.cornerRadius = 20
        fourthExsButton.setTitle("Подъем гантелей на бицепс", for: .normal)
        fourthExsButton.setTitleColor(.black, for: .normal)
        
        fifthExsButton.backgroundColor = buttonColor
        fifthExsButton.layer.cornerRadius = 20
        fifthExsButton.setTitle("Подтягивания обратным хватом", for: .normal)
        fifthExsButton.setTitleColor(.black, for: .normal)
        
        trainConteinerView.addSubview(firstExsButton)
        trainConteinerView.addSubview(secondExsButton)
        trainConteinerView.addSubview(thirdExsButton)
        trainConteinerView.addSubview(fourthExsButton)
        trainConteinerView.addSubview(fifthExsButton)
        
        firstExsButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(trainLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        secondExsButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(firstExsButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        thirdExsButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(secondExsButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        fourthExsButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(thirdExsButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        fifthExsButton.snp.makeConstraints { make in
            make.width.equalTo(buttonWidth)
            make.height.equalTo(buttonHeight)
            make.top.equalTo(fourthExsButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func setupCompleatedButton() {
        completedButton.backgroundColor = #colorLiteral(red: 0.9535692334, green: 0.4975354075, blue: 0.4972377419, alpha: 1)
        completedButton.setTitle("Выполнил", for: .normal)
        completedButton.layer.cornerRadius = 20
        
        view.addSubview(completedButton)
        
        completedButton.snp.makeConstraints { make in
            make.width.equalTo(280)
            make.height.equalTo(50)
            make.top.equalTo(trainConteinerView.snp.bottom).offset(80)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupDietLabel() {
        dietLabel.textAlignment = .center
        dietLabel.text = "Введите ваш сегодняшний рацион"
        dietLabel.numberOfLines = 2
        dietLabel.isHidden = true
        dietLabel.font = .systemFont(ofSize: 20)
        
        view.addSubview(dietLabel)
        
        dietLabel.snp.makeConstraints{ make in
            make.width.equalTo(300)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentControl.snp.bottom).offset(80)
        }
    }
    
    func setupStackView(){
        stackView.isHidden = true
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(dietLabel.snp.bottom).offset(20)
            make.width.equalTo(300)
        }
    }
    
    func setupInputTextField() {
        inputTextField.backgroundColor = #colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1)
        inputTextField.layer.cornerRadius = 20
        inputTextField.isHidden = true
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: inputTextField.frame.height))
        inputTextField.leftViewMode = .always
        inputTextField.setContentHuggingPriority(.required, for: .vertical)
        inputTextField.setContentCompressionResistancePriority(.required, for: .vertical)
        
        stackView.addArrangedSubview(inputTextField)
        
        inputTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    func setupAddButton() {
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = #colorLiteral(red: 0.825640142, green: 0.4129830003, blue: 0.4117295742, alpha: 1)
        addButton.layer.cornerRadius = 20
        addButton.isHidden = true
        addButton.addTarget(self, action: #selector(addNewField), for: .touchUpInside)
        
        stackView.addArrangedSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(20)
            make.width.height.equalTo(50)
        }
    }
    
    @objc func addNewField() {
        // Проверяем, что поле ввода не пустое
        guard let text = inputTextField.text, !text.isEmpty else { return }
        
        // Создаем новый UILabel
        let newLabel = UILabel()
        newLabel.backgroundColor = #colorLiteral(red: 0.850980401, green: 0.850980401, blue: 0.850980401, alpha: 1)
        newLabel.layer.cornerRadius = 20
        newLabel.text = text
        
        // Установка размера шрифта
        newLabel.font = UIFont.systemFont(ofSize: 16) // Установите нужный вам размер шрифта
        
        newLabel.setContentHuggingPriority(.required, for: .vertical)
        newLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        // Добавляем новый лейбл в stackView
        stackView.insertArrangedSubview(newLabel, at: stackView.arrangedSubviews.count - 1)
        
        // Очищаем поле ввода
        inputTextField.text = ""
    }
    
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        let shouldHideTrainItems = selectedIndex == 1
        let shouldHideDietItem = selectedIndex == 0
        
        trainConteinerView.isHidden = shouldHideTrainItems
        trainLabel.isHidden = shouldHideTrainItems
        firstExsButton.isHidden = shouldHideTrainItems
        secondExsButton.isHidden = shouldHideTrainItems
        thirdExsButton.isHidden = shouldHideTrainItems
        fourthExsButton.isHidden = shouldHideTrainItems
        fifthExsButton.isHidden = shouldHideTrainItems
        completedButton.isHidden = shouldHideTrainItems
        
        dietLabel.isHidden = shouldHideDietItem
        stackView.isHidden = shouldHideDietItem
        inputTextField.isHidden = shouldHideDietItem
        addButton.isHidden = shouldHideDietItem
    }
    
    @objc func switchToEditController() {
        interactor?.navigateToPresenter()
    }
}
    
extension MainMenuViewController: MainMenuDisplayLogic {
        
    func dataToInteractor() {
        interactor?.getData(userId: userId)
    }
        
    func updateInterfaceWithProcessedData(username: String, gender: String, sportExp: String,sportExpNext: String, preference: String, time: Int) {
        
        helloLabel.text = "Привет, \(username)!"
    }
}

