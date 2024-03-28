import UIKit
protocol MainMenuFactory {
    func makeMainMenuViewController(userId: String) -> UIViewController
}

extension MainMenuFactory {
    func makeMainMenuViewController(userId: String) -> UIViewController {
        let interactor = MainMenuInteractor()
        let viewController = MainMenuViewController(userId: userId)
        var router: MainMenuRouter = MainMenuRouterImpl()
        router.viewController = viewController
        let presenter = MainMenuPresenter(router: router)
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor

        return viewController
    }
}

final class MainMenuFactoryImpl: MainMenuFactory {}
