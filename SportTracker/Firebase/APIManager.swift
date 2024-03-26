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
    
    func getPost(collection: String, docName: String, completion: @escaping(Document?) -> Void) {
        let db = configureFB()
        db.collection(collection).document(docName).getDocument(completion: { (document, error ) in
            guard error == nil else { completion(nil); return }
            let doc = Document(field1: document?.get("field1") as! String, field2: document?.get("field2") as! String)
            completion(doc)
            
        })
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
}
