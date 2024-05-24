//
//  APIManager.swift
//  SportTracker
//
//  Created by Вадим Амбарцумян on 16.03.2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class APIManager {
    
    static let shared = APIManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        return db
    }
    
    func getUserData(userID: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        // Получаем ссылку на коллекцию "users" в Firestore и документ с UID пользователя
        let userDocRef = Firestore.firestore().collection("date").document(userID)
        
        // Получаем данные пользователя из Firestore
        userDocRef.getDocument { document, error in
            if let error = error {
                // Если возникла ошибка, передаем ее обратно через замыкание completion
                completion(nil, error)
            } else if let document = document, document.exists {
                // Если документ пользователя существует, извлекаем его данные и передаем их обратно через замыкание completion
                let userData = document.data()
                completion(userData, nil)
            } else {
                // Если документ пользователя не существует, передаем nil через замыкание completion
                completion(nil, nil)
            }
        }
    }

    
    func sendDataToFirestore(collection: String, userID: String, data: [String: Any], completion: @escaping (Error?) -> Void) {
        // Получаем ссылку на Firestore
        let db = Firestore.firestore()
        
        // Определяем коллекцию, куда будем отправлять данные
        let collectionReference = db.collection(collection)
        
        // Создаем ссылку на документ пользователя
        let documentReference = collectionReference.document(userID)
        
        // Проверяем существование документа пользователя
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                // Если документ существует, обновляем его данные
                documentReference.updateData(data) { error in
                    completion(error)
                }
            } else {
                // Если документ не существует, создаем новый
                documentReference.setData(data) { error in
                    completion(error)
                }
            }
        }
    }
    
    func fetchData(fromCollection collection: String, document: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let db = Firestore.firestore()
        
        let docRef = db.collection(collection).document(document)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error) // Если есть ошибка, передаем ее через completion
                return
            }
            
            guard let document = document, document.exists else {
                let error = NSError(domain: "YourDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                completion(nil, error) // Если документ не существует, создаем ошибку и передаем через completion
                return
            }
            
            let data = document.data()
            completion(data, nil) // Передаем данные через completion
        }
    }
}
