import UIKit
import SnapKit

final class SplashScreenViewController: UIViewController {
    
    let textLabel = UILabel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let secondViewController = AuthViewController()

        // Устанавливаем анимацию перехода
        UIView.transition(with: view.window!,
                          duration: 1.5,
                          options: .transitionCrossDissolve,
                          animations: {
                              // Выполняем переход на второй ViewController
                              self.navigationController?.pushViewController(secondViewController, animated: false)
                          },
                          completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "Fone")
        let background = UIImageView(image: backgroundImage)
        background.contentMode = .scaleToFill
        
        view.addSubview(background)
        
        background.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        let iconImage = UIImage(named: "Launch")
        let icon = UIImageView(image: iconImage)
        
        view.addSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-56)
        }
        
        textLabel.text = "Ваш личный спорт-трекер"
        textLabel.textAlignment = .center
        textLabel.font = .systemFont(ofSize: 36)
        textLabel.numberOfLines = 2
        
        view.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(120)
            make.top.equalToSuperview().offset(190)
        }
    }
}

