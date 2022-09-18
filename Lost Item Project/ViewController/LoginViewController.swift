//
//  ViewController.swift
//  Lost Item Project
//
//  Created by Jerry Chi Chong Lam on 12/9/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var forgetPwBtn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // only support portrait mode
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Circle button
        forgetPwBtn.layer.cornerRadius = forgetPwBtn.frame.width / 2
        forgetPwBtn.layer.masksToBounds = true
        
        nameTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func onClickSignInBtn(_ sender: UIButton) {
        // initiate main View of the project
        let containerViewController = ContainerViewController()
        containerViewController.modalPresentationStyle = .fullScreen
        self.present(containerViewController, animated: true, completion: nil)
    }
}

extension LoginViewController:UITextFieldDelegate {
    // called when return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide soft keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // called when user clicks on view outside UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // hide soft keyboard
        self.view.endEditing(true)
    }
}
