//
//  ViewController.swift
//  ChangeViewBackgroundColor
//
//  Created by Александр Рахимов on 29.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let viewForPaint: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let completionButton = UIButton()
    let delegateButton = UIButton()
    let notificationButton = UIButton()
    
    var buttons: [UIButton] = []
    let titlesForButtons = ["completion", "delegate", "notification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Set color to view"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        fillButtonsArray()
        
        completionButton.addTarget(self, action: #selector(goToCompletionVC), for: .touchUpInside)
        delegateButton.addTarget(self, action: #selector(goToDelegateVC), for: .touchUpInside)
        notificationButton.addTarget(self, action: #selector(goToNotificationVC), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setViewForPaint()
        addButtonsToView()
        notificationsObserverWithUserInfo()
        notificationObserver()
    }

    private func setViewForPaint() {
        view.addSubview(viewForPaint)
        
        viewForPaint.widthAnchor.constraint(equalToConstant: 300).isActive = true
        viewForPaint.heightAnchor.constraint(equalToConstant: 300).isActive = true
        viewForPaint.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        viewForPaint.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }
    
    private func fillButtonsArray() {
        buttons.append(completionButton)
        buttons.append(delegateButton)
        buttons.append(notificationButton)
    }
    
    private func addButtonsToView() {
        var count = 0
        var xPosition = view.bounds.size.width / 5
        
        for button in buttons {
            button.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
            button.center = CGPoint(x: xPosition, y: view.bounds.size.height - 100)
            button.backgroundColor = .white
            button.setTitle(titlesForButtons[count], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 10
            view.addSubview(button)
            count += 1
            xPosition += 120
        }
    }

    @objc private func goToCompletionVC() {
        let completionVC = CompletionViewController()
        navigationController?.pushViewController(completionVC, animated: false)
        completionVC.completionHandler = { [weak self] color in
            guard let self = self else { return }
            self.viewForPaint.backgroundColor = color
        }
    }
    
    @objc private func goToDelegateVC() {
        let delegateVC = DelegateViewController()
        navigationController?.pushViewController(delegateVC, animated: false)
        delegateVC.delegate = self
    }
    
    @objc private func goToNotificationVC() {
        let notificationVC = NotificationViewController()
        navigationController?.pushViewController(notificationVC, animated: false)
    }
    
}

// MARK: - delegate

extension MainViewController: ChangeColorDelegate {
    func changeBackgroundColorView(color: UIColor) {
        viewForPaint.backgroundColor = color
    }
}

// MARK: - Notifications

extension MainViewController {
    
    private func notificationsObserverWithUserInfo() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(actionAfterNotification), name: Notification.Name("PurpleButtonTapped"), object: nil)
    }
    
    @objc private func actionAfterNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let color = userInfo["color"] as? UIColor else { return }
        viewForPaint.backgroundColor = color
    }
    
    private func notificationObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(actionObserver), name: NSNotification.Name("cyan"), object: nil)
    }
    
    @objc private func actionObserver() {
        viewForPaint.backgroundColor = .cyan
    }
}
