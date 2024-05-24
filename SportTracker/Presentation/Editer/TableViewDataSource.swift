import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    private var data: [(label: String, value: String)] = [
        ("Уровень подготовки", ""),
        ("Время для тренировки", ""),
        ("Рост", ""),
        ("Вес", "")
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as! EditTableViewCell
        cell.configure(with: self.data[indexPath.row]) { updatedValue in
            self.data[indexPath.row].value = updatedValue
        }
        return cell
    }
}
