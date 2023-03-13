//
//  UploadViewController.swift
//  InstaClone
//
//  Created by Ali Berkay BERBER on 5.03.2023.
//

import UIKit
import Firebase
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var commentTexfield: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        selectedImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert(titleInput: String , massageInput: String) {
        let alert = UIAlertController(title: titleInput, message: massageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = selectedImage.image?.jpegData(compressionQuality: 0.5) {
            
            let uuıd = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuıd).jpg")
            imageReference.putData(data) { metaData, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", massageInput: error?.localizedDescription ?? "Error!")
                }
                else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                            
                            //MARK: database
                            
                            let fireStoreDatabase = Firestore.firestore()
                            var fireStoreReference: DocumentReference? = nil
                            
                            let fireStorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email, "postComment": self.commentTexfield.text!, "date": FieldValue.serverTimestamp(), "likes": 0]
                            fireStoreReference = fireStoreDatabase.collection("Posts").addDocument(data: fireStorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", massageInput: error?.localizedDescription ?? "Error!")
                                } else {
                                    
                                    self.selectedImage.image = UIImage(named: "selectImage.png")
                                    self.commentTexfield.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                            
                        }
                    }
                }
            }
        }
        
    }
    
}
