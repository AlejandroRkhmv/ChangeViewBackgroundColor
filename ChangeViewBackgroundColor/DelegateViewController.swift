//
//  DelegateViewController.swift
//  ChangeViewBackgroundColor
//
//  Created by Александр Рахимов on 29.01.2023.
//

import UIKit

protocol ChangeColorDelegate: AnyObject {
    func changeBackgroundColorView(color: UIColor)
}

class DelegateViewController: UIViewController {

    let greenButton = UIButton()
    let yellowButton = UIButton()
    
    weak var delegate: ChangeColorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Go back", style: .plain, target: self, action: #selector(backButtonTapped))
        newBackButton.tintColor = .white
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    override func viewDidAppear(_ animated: Bool) {
        
        createGreenView()
        createYellowView()
        
        greenButton.addTarget(self, action: #selector(goToMainGreen), for: .touchUpInside)
        yellowButton.addTarget(self, action: #selector(goToMainYellow), for: .touchUpInside)
    }

    private func createGreenView() {
        greenButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        greenButton.center = CGPoint(x: view.center.x - 100, y: view.center.y)
        greenButton.backgroundColor = .green
        view.addSubview(greenButton)
    }
    
    private func createYellowView() {
        yellowButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        yellowButton.center = CGPoint(x: view.center.x + 100, y: view.center.y)
        yellowButton.backgroundColor = .yellow
        view.addSubview(yellowButton)
    }
    
    @objc func goToMainGreen() {
        navigationController?.popViewController(animated: false)
        guard let greenButtonColor = greenButton.backgroundColor else { return }
        delegate?.changeBackgroundColorView(color: greenButtonColor)
    }
    
    @objc func goToMainYellow() {
        navigationController?.popViewController(animated: false)
        guard let yellowButtonColor = yellowButton.backgroundColor else { return }
        delegate?.changeBackgroundColorView(color: yellowButtonColor)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}
