//
//  FirebaseManager.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 22.01.2024.
//

import Foundation
import UIKit
import Firebase


class FirebaseManager {
    
    func registNewUser(user: UserData, completion: @escaping (String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, err in
            if let error = err {
                completion(nil, error) // В случае ошибки передаем nil для userID и объект ошибки
            } else {
                if let userID = result?.user.uid {
                    completion(userID, nil) // В случае успеха передаем userID и nil для ошибки
                } else {
                    completion(nil, NSError(domain: "YourDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "UserID not found"])) // В случае ошибки передаем nil для userID и объект ошибки
                }
            }
        }
    }

    func loginUser(email: String, password: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Ошибка входа: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let userId = result?.user.uid {
                // Успешный вход, теперь получаем данные пользователя из Firestore
                Firestore.firestore().collection("date").document(userId).getDocument { document, error in
                    if let document = document, document.exists {
                        // Документ пользователя найден, извлекаем данные
                        let userData = document.data()
                        completion(userId)
                    } else {
                        // Документ пользователя не найден
                        print("Данные пользователя не найдены в Firestore.")
                        completion(nil)
                    }
                }
                
            } else {
                print("Не удалось получить UID пользователя.")
                completion(nil)
            }
        }
    }
}

struct UserData {
    var email: String
    var name: String
    var password: String
}
