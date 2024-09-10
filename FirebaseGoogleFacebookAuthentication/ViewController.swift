
import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    
    
    @IBOutlet var txtEml: UITextField!
    @IBOutlet var txtPswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPswd.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        guard let email = txtEml.text, !email.isEmpty else {
            showAlert(message: "Please enter an email address")
            return
        }
        
        guard let password = txtPswd.text, !password.isEmpty else {
            
            showAlert(message: "Please enter a password")
            return
        }
        
        if !isValidEmail(email: email) {
            showAlert(message: "Invalid email format")
            return
        }
        
        if !isValidPassword(password: password) {
            showAlert(message: "Password must be 8 characters long, include an uppercase letter, a number, and a special character")
            return
        }
        
        login(email: email, password: password)
        
    }
    
    @IBAction func btnGoogle(_ sender: UIButton) {
        
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
//                if let error = error {
//                    print("Error during Google Sign-In: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let user = signInResult?.user else { return }
//                let email = user.profile?.email
//                print("User signed in with email: \(email ?? "No Email")")
//            }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                        if let error = error {
                            print("Error during Google Sign-In: \(error.localizedDescription)")
                            return
                        }
         
                        guard let user = signInResult?.user else { return }
                        let email = user.profile?.email
                        print("User signed in with email: \(email ?? "No Email")")
         
                        // Get the Google authentication token
                    guard let authentication = user.idToken else {
                            print("Error retrieving Google authentication token.")
                            return
                        }
         
                        // Create a Firebase credential using the Google ID token
                    let credential = GoogleAuthProvider.credential(withIDToken: authentication.tokenString, accessToken: user.accessToken.tokenString)
         
                        // Sign in to Firebase with the Google credential
                        Auth.auth().signIn(with: credential) { (authResult, error) in
                            if let error = error {
                                self.showAlert(message: error.localizedDescription)
                                return
                            }
         
                            // Sign-in successful
                            self.showAlert(message: "Your account has been Verified successfully.")
                        }
                    }
      
        
    }
    
    @IBAction func btnFacebook(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func btnSignup(_ sender: UIButton) {
        
        
        
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
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func login(email: String, password: String) {
            // Perform login operation (e.g., API call or further logic)
            print("Logging in with email: \(email) and password: \(password)")
        } 
    
}

