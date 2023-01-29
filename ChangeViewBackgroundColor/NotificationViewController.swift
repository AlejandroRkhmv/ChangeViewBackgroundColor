//
//  NotificationViewController.swift
//  ChangeViewBackgroundColor
//
//  Created by Александр Рахимов on 29.01.2023.
//

import UIKit

class NotificationViewController: UIViewController {

    let purpleButton = UIButton()
    let cyanButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Go back", style: .plain, target: self, action: #selector(backButtonTapped))
        newBackButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createPurpleView()
        createCyanView()
        
        purpleButton.addTarget(self, action: #selector(goToMainPurple), for: .touchUpInside)
        cyanButton.addTarget(self, action: #selector(goToMainCyan), for: .touchUpInside)
    }
 
    private func createPurpleView() {
        purpleButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        purpleButton.center = CGPoint(x: view.center.x - 100, y: view.center.y)
        purpleButton.backgroundColor = .purple
        view.addSubview(purpleButton)
    }
    
    private func createCyanView() {
        cyanButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        cyanButton.center = CGPoint(x: view.center.x + 100, y: view.center.y)
        cyanButton.backgroundColor = .cyan
        view.addSubview(cyanButton)
    }
    
    @objc func goToMainPurple() {
        navigationController?.popViewController(animated: false)
        guard let purpleButtonColor = purpleButton.backgroundColor else { return }
        let color = ["color": purpleButtonColor]
        let notification = NotificationCenter.default
        notification.post(name: Notification.Name("PurpleButtonTapped"), object: nil, userInfo: color)
    }
    
    @objc func goToMainCyan() {
        navigationController?.popViewController(animated: false)
        let notification = NotificationCenter.default
        notification.post(name: Notification.Name("cyan"), object: nil)
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}
