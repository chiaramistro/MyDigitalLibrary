//
//  ToastViewController.swift
//  MyDigitalLibrary
//
//  Created by Chiara Mistrorigo on 08/04/24.
//

import UIKit

extension UIViewController {
    
    func showToast(message: String) {
        let toastWidth = self.view.frame.size.width-16
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - (toastWidth/2), y: self.view.safeAreaInsets.top, width: toastWidth, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
