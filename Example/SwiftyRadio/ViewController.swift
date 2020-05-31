//
//  ViewController.swift
//  SwiftyRadio
//
//  Created by Ibrahim F on 05/31/2020.
//  Copyright (c) 2020 Ibrahim F. All rights reserved.
//

import UIKit
class ViewController: UIViewController, SwiftyRadioDelegate {
    func didSelectRadio(index: Int, text: String) {
        print("Selected:", index, text)
    }
    
    func didDeSelectRadio(index: Int, text: String) {
        print("DeSelected", index, text)
    }
    var radioButtons: SwiftyRadio!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let config = SwiftyRadioConfig()
        config.cornerRaduis         = 5.0
        config.borderColor          = .systemBlue
        config.borderWidth          = 2
        config.buttonsBackgroundColor = .systemBackground
        config.textColor            = .systemBlue
        config.selectedTextColor    = .systemBackground
        config.flowDirection        = .horizontal
        config.spacing              = 10
        config.options              = ["One", "Two", "Three"]
        config.isNarrow             = false
        config.isMuliple            = false
        radioButtons = SwiftyRadio(config: config)
        view.addSubview(radioButtons)
        radioButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            radioButtons.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -25),
            radioButtons.heightAnchor.constraint(equalToConstant: 100),
            radioButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radioButtons.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        let button = UIButton(type: .system)
        button.setTitle("Get current selected", for: .normal)
        button.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // If you want to get the current selected on some action
    @objc func handleButton(_ sender: UIButton) {
        print(radioButtons.currentSelectedButtons)
    }
}

