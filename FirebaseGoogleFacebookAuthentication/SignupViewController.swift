//
//  SignupViewController.swift
//  FirebaseGoogleFacebookAuthentication
//
//  Created by Samir Raut on 10/09/24.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var txtUsrNm: UITextField!
    @IBOutlet var txtEml: UITextField!
    @IBOutlet var txtPswd: UITextField!
    @IBOutlet var txtConfrmPswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtPswd.isSecureTextEntry = true
        txtConfrmPswd.isSecureTextEntry = true
        
    }
    
    
    @IBAction func btnSignup(_ sender: UIButton) {
        
        if isValid() {
            if txtPswd.text == txtConfrmPswd.text {
                showAlert(message: "Account Created Successfully")
            } else {
                showAlert(message: "Password do not match")
                txtConfrmPswd.text = ""
            }
        }
        
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
       
        
    }
    
    func isValid() -> Bool
    {
        
        guard let username = txtUsrNm.text, !username.isEmpty else {
            showAlert(message: "Username must be 3-20 characters long and contain only letters and numbers")
            return false
        }
        
        guard let email = txtEml.text, !email.isEmpty else {
            showAlert(message: "Please enter an email address")
            return false
        }
        
        guard let password = txtPswd.text, !password.isEmpty else {
            showAlert(message: "Please enter a password")
            return false
        }
        
        guard let confirmPassword = txtConfrmPswd.text, !confirmPassword.isEmpty else {
            showAlert(message: "Passwords do not match. Please try again")
            return false
        }
        
        if !isValidUsername(username: username) {
            showAlert(message: "Invalid username format")
            return false
        }
        
        if !isValidEmail(email: email) {
            showAlert(message: "Invalid email format")
            return false
        }
         
        if !isValidPassword(password: password) {
            showAlert(message: "Password must be 8 characters long, include an uppercase letter, a number, and a special character")
            return false
        }
        
        login(username: username, email: email, password: password)
        
        return true
        
    }
    
    func isValidUsername(username: String) -> Bool {
        let usernameRegEx = "^[a-zA-Z0-9]{3,20}$"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,64}$"
        
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }
    
    func login(username: String, email: String, password: String) {
            // Perform login operation (e.g., API call or further logic)
            print("Logging in with username: \(username), email: \(email) and password: \(password)")
        }
    
    func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
}
