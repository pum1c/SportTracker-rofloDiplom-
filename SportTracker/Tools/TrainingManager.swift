//
//  TrenManager.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 06.05.2024.
//

import Foundation

enum TrainingLevel {
    case beginner
    case intermediate
    case professional
}

enum TrainingDay {
    case chest(level: TrainingLevel)
    case back(level: TrainingLevel)
    case legs(level: TrainingLevel)
}

class TrainingManager {
    
    var lastFetchedData: [String: Any]? // Свойство для хранения последнего полученного массива данных

    let db = APIManager()
    
    func planTraining(for day: TrainingDay,  completion: @escaping ([String: Any]?, Error?) -> Void) {
        switch day {
        case .chest(let level):
            switch level {
            case .beginner:
                db.fetchData(fromCollection: "chest&bic", document: "forNew") { (data, error) in
                    if let error = error {
                        print("Error fetching document: \(error)")
                    } else {
                        if let data = data {
                            self.lastFetchedData = data
                            completion(data, error)
                            print("Fetched data: \(data)")
                            self.lastFetchedData = data
                            completion(data, error)
                        } else {
                            print("No data available")
                            self.lastFetchedData = data
                            completion(data, error)
                        }
                    }
                }
            case .intermediate:
                db.fetchData(fromCollection: "chest&bic", document: "forMed") { (data, error) in
                    if let error = error {
                        print("Error fetching document: \(error)")
                    } else {
                        if let data = data {
                            self.lastFetchedData = data
                            completion(data, error)
                            print("Fetched data: \(data)")
                        } else {
                            self.lastFetchedData = data
                            completion(data, error)
                            print("No data available")
                        }
                    }
                }

            case .professional:
                db.fetchData(fromCollection: "chest&bic", document: "forProf") { (data, error) in
                    if let error = error {
                        print("Error fetching document: \(error)")
                    } else {
                        if let data = data {
                            self.lastFetchedData = data
                            completion(data, error)
                            print("Fetched data: \(data)")
                        } else {
                            self.lastFetchedData = data
                            completion(data, error)
                            print("No data available")
                        }
                    }
                }

            }
        case .back(let level):
            switch level {
            case .beginner:
                print("Тренировка спины для новичка: выполняйте упражнения на спину с использованием тренажеров, такие как тяга верхнего блока и подтягивания.")
            case .intermediate:
                print("Тренировка спины для среднего уровня: добавьте базовые упражнения со штангой, например, становую тягу и тягу штанги к поясу.")
            case .professional:
                print("Профессиональная тренировка спины: включите упражнения с свободными весами, такие как мертвая тяга и однорукие тяги гантелей.")
            }
        case .legs(let level):
            switch level {
            case .beginner:
                print("Тренировка ног для новичка: выполняйте базовые упражнения, такие как приседания со свободным весом и выпады.")
            case .intermediate:
                print("Тренировка ног для среднего уровня: добавьте упражнения на мощность, такие как жим ногами и гак-приседания.")
            case .professional:
                print("Профессиональная тренировка ног: включите изолирующие упражнения, такие как разведение ног в тренажере и становая тяга на одной ноге.")
            }
        }
    }
}
