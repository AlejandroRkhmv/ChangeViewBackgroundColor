//
//  CompletionViewController.swift
//  ChangeViewBackgroundColor
//
//  Created by Александр Рахимов on 29.01.2023.
//

import UIKit

class CompletionViewController: UIViewController {

    let blueButton = UIButton()
    let redButton = UIButton()
    var completionHandler: ((UIColor) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Go back", style: .plain, target: self, action: #selector(backButtonTapped))
        newBackButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        createBlueView()
        createRedView()
        
        blueButton.addTarget(self, action: #selector(goToMainBlue), for: .touchUpInside)
        redButton.addTarget(self, action: #selector(goToMainRed), for: .touchUpInside)
    }

    private func createBlueView() {
        blueButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        blueButton.center = CGPoint(x: view.center.x - 100, y: view.center.y)
        blueButton.backgroundColor = .blue
        view.addSubview(blueButton)
    }
    
    private func createRedView() {
        redButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        redButton.center = CGPoint(x: view.center.x + 100, y: view.center.y)
        redButton.backgroundColor = .red
        view.addSubview(redButton)
    }
    
    @objc func goToMainBlue() {
        navigationController?.popViewController(animated: false)
        guard let blueButtonColor = blueButton.backgroundColor else { return }
        completionHandler?(blueButtonColor)
    }
    
    @objc func goToMainRed() {
        navigationController?.popViewController(animated: false)
        guard let redButtonColor = redButton.backgroundColor else { return }
        completionHandler?(redButtonColor)
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}
