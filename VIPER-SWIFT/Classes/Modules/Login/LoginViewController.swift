//
//  LoginViewController.swift
//  hsg.app.login
//
//  Created by admin on 2018/11/14.
//  Copyright © 2018年 clcw. All rights reserved.
//

import UIKit
//@objc(LoginViewController)
class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.source
        // Do any additional setup after loading the view.
        title = "Login"
    }
//    @objc (loginPressed:)
     @IBAction func loginPressed(_ sender: Any) {
        
        if let userName = userNameTextField.text,
            let password = passwordTextField.text
        {
            let indicator = UIActivityIndicatorView.showInView(view: view)
            /***/
            APIClient.login(userName: userName, pwd: password, completionHandler: { (successful, error) -> () in
                
                indicator.hide()
                
                if successful {
                    self.dismiss(animated: true, completion: nil)
//                    self.performSegue(withIdentifier: "showDetail", sender: sender)
                } else {
                    switch error! {
                    case .EmptyUserName, .EmptyPassword:
                        UIAlertController.showAlertTitle(title: "", message: "Empty username/password", cancelButtonTitle: "OK", fromViewController: self)
                    case .UserNotFound:
                        UIAlertController.showAlertTitle(title: "", message: "User not exists", cancelButtonTitle: "OK", fromViewController: self)
                    case .WrongPassword:
                        UIAlertController.showAlertTitle(title: "", message: "Wrong password", cancelButtonTitle: "OK", fromViewController: self)
                    }
                }
            })
        }  else {
            fatalError("should not hit here")
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! DetailViewController).userName = userNameTextField.text
    }
}
extension UIAlertController {
    static func showAlertTitle(title: String?, message: String?, cancelButtonTitle: String?, fromViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}

var activityShowingCount = 0
extension UIActivityIndicatorView {
    
    static func showInView(view: UIView) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.center = view.center
        
        view.addSubview(indicator)
        indicator.startAnimating()
        
        if activityShowingCount == 0 {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
        
        activityShowingCount += 1
        
        return indicator
    }
    
    func hide() {
        activityShowingCount -= 1
        if activityShowingCount == 0 {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
        removeFromSuperview()
    }
}
