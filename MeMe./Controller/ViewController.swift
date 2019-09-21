//
//  ViewController.swift
//  MeMe.
//
//  Created by نورة . on 04/09/2019.
//  Copyright © 2019 نورة . All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    
    // Outlet 
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePikerView: UIImageView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var albomeBar: UIBarButtonItem!
    @IBOutlet weak var shareImage: UIBarButtonItem!
    
    func prepareTextField(textField: UITextField, defaultText: String) {
        let memeTextAttributes:[NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor : UIColor.blue,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 33)!,
            NSAttributedString.Key.strokeWidth : -4.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        textField.textAlignment = .center
        textField.text = defaultText
      
    }
    //Mark Font stayle
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        prepareTextField(textField: topTextField, defaultText:"TOP")
        prepareTextField(textField: buttomTextField, defaultText:"BOTTOM")
    }
    
    
    
    
    
    //MARK Check if camera is available
   override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    if imagePikerView.image == nil {shareImage.isEnabled = false} else {shareImage.isEnabled = true}
    //MARK  keyboard notifications
    subscribeToKeyboardNotifications()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    //MARK FunKeyboard
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:  UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
     //MARK Func Keyboard Will Show
    @objc func keyboardWillShow(_ notification:Notification) {
        if buttomTextField.isFirstResponder {
          self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    //MARK Func Keyboard Will Hide
    @objc func keyboardWillHide(notification: NSNotification) {
        if buttomTextField.isFirstResponder {
           self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //Mark When a selact Image by user and then save him
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePikerView.contentMode = .scaleAspectFit
            imagePikerView.image = image
            picker.dismiss(animated: true, completion: nil)
        }}

    
    //Mark func pick An Image From Album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
              pickAnImage(sourceType: .photoLibrary)
    }
    
    //MARK func pick An Image From Camera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
          pickAnImage(sourceType: .camera)
    }
    
    
    
    func pickAnImage (sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    

    // MARK save image
    
    func save(memedImage: UIImage){
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: buttomTextField.text!, image: imagePikerView.image!, memedImage: generateMemedImage())
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
        
        
        
        
    }
    
    //MARK Hide toolbar and navbar
    private func hideToolBar(_ hide: Bool) {
        navigationController?.navigationBar.isHidden = hide
        toolBar.isHidden = hide
        view.backgroundColor = hide ? .clear : .black
    }
    
    
    func generateMemedImage() -> UIImage {
        
        //  Hide toolbar and navbar
        hideToolBar(true)
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //  Show toolbar and navbar
          hideToolBar(false)
        return memedImage
    }
    
    //Mark share
    @IBAction func shareAction (){
        let memeImage = generateMemedImage()
        let activity = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        activity.completionWithItemsHandler = { (_, completed, _, _) in
            if(completed) {
                self.save(memedImage: memeImage)
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activity, animated: true)
    }
    
    
    //Mark cancel
    @IBAction func cancel (){
        topTextField.text = "TOP"
        buttomTextField.text = "BOTTOM"
        imagePikerView.image = nil
        shareImage.isEnabled = false
       self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    //MARK Clear
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
}
