//
//  MainVC.swift
//  popoverVC
//
//  Created by George Weaver on 15.05.2023.
//

import UIKit

class MainVC: UIViewController {
    
    var popoverHeight: CGFloat = 280
    
    private let presentLabel: UILabel = {
        let label = UILabel()
        label.text = "Present"
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupGesture()
        setupLayout()
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white.withAlphaComponent(0.95)
    }
    
    private func setupGesture() {
        let tapGR = UITapGestureRecognizer()
        tapGR.addTarget(self, action: #selector(labelTapped))
        presentLabel.addGestureRecognizer(tapGR)
    }
    
    private func setupLayout() {
        view.addSubviesWithAutoresizing(presentLabel)
        
        NSLayoutConstraint.activate([
            presentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            presentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func labelTapped(_ sender: UIView) {
        presentLabel.textColor = .lightGray
        let popover = PopoverVC()
        popover.modalPresentationStyle = .popover
        let popoverVC = popover.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = presentLabel
        popoverVC?.sourceRect = CGRect(x: presentLabel.bounds.midX, y: presentLabel.bounds.midY, width: 0, height: 15)
        
        popoverVC?.permittedArrowDirections = UIPopoverArrowDirection.up
        
        present(popover, animated: true) { [weak self] in
            popover.routing = {
                popover.dismiss(animated: true)
                self?.presentLabel.textColor = .systemBlue
            }
        }
    }


}

extension MainVC: UIPopoverPresentationControllerDelegate {
     
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension MainVC: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }
}
