//
//  PopoverVC.swift
//  popoverVC
//
//  Created by George Weaver on 15.05.2023.
//

import Foundation
import UIKit

final class PopoverVC: UIViewController {
    
    var routing: (() -> Void)?
    
    private let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["280pt", "150pt"])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .lightGray
        segment.selectedSegmentTintColor = .white
        segment.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        return segment
    }()
    
    private let dissmissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(
            systemName: "x.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupLayout()
        addActions()
    }
    
    private func setupAppearance() {
        view.backgroundColor = .white
        preferredContentSize = CGSize(width: 300, height: 280)
    }
    
    private func addActions() {
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        dissmissButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubviesWithAutoresizing(segmentedControl, dissmissButton)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dissmissButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            dissmissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dissmissButton.heightAnchor.constraint(equalToConstant: 30),
            dissmissButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc
    private func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.preferredContentSize.height = 280
        case 1:
            self.preferredContentSize.height = 150
        default:
            break
        }
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
        routing?()
    }
}

extension UIView {
    
    func addSubviesWithAutoresizing(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
