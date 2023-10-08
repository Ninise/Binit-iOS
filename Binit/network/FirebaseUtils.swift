//
//  FirebaseUtils.swift
//  Binit
//
//  Created by Nikita on 08.10.2023.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import UIKit

class FirebaseUtils {
    
    static let shared = FirebaseUtils()
    
    var storage: Storage
    var storageRef: StorageReference
    
    init() {
        self.storage = Storage.storage(url: "gs://binit-e50ef.appspot.com")
        self.storageRef = storage.reference()
    }
    
    func uploadImage(image: UIImage, completion: @escaping (String?) -> Void) {
        
        Auth.auth().signInAnonymously { authResult, error in
            
            let imageName = "\(UUID().uuidString)_IOS"
            
            let imageRef = self.storageRef.child("\(imageName)")
            
            if let uploadData = image.jpegData(compressionQuality: 0.5) {
                
                imageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                    
                    imageRef.downloadURL { (url, error) in
                                                
                        let urlString = url?.absoluteString
                        
                        completion(urlString)
                    }

                    
                   
                }
            }
            
        }
        
        
    }
    
}
