import Foundation
import UIKit
import SnapKit

class EditerViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    let tableViewDataSource = TableViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(self.tableView)
        self.tableView.register(EditTableViewCell.self, forCellReuseIdentifier: "EditTableViewCell")
        self.tableView.dataSource = tableViewDataSource
        
        self.updateLayout(with: self.view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (context) in
            self.updateLayout(with: size)
        }, completion: nil)
    }
    
    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect(origin: .zero, size: size)
    }
}
