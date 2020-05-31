//
//  SwiftyRadio.swift
//  SwiftyRadio
//
//  Created by Ibrahim F on 31/05/2020.
//

import UIKit

class SwiftyRadio: UIStackView {
    
    fileprivate let config: SwiftyRadioButtonsConfig
    // MARK: - View initilization
    init(config: SwiftyRadioButtonsConfig, frame: CGRect = .zero){
        self.config = config
        super.init(frame: frame)
        setup()
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var tags: [Int] =  []
    var delegate: SwiftyRadioButtonsDelegate?
    
    /// Get or Set current selected buttons
    public var currentSelectedButtons: [Int] {
        get {
            var selectedTags: [Int] = []
            tags.forEach {
                print($0)
                if let button = viewWithTag($0) as? SwiftyRadioButtonView {
                    if button.isButtonActive {
                        if let tagIndex = tags.firstIndex(of: $0){
                            print(tagIndex)
                            selectedTags.append(tagIndex)
                        }
                    }
                }
            }
            return selectedTags
        } set {
            let buttonsToBeSelected = newValue
            buttonsToBeSelected.forEach {
                if let buttonToBeSelected = tags.firstIndex(of: $0) {
                    toggleButton(tag: buttonToBeSelected)
                }
            }
        }
    }
    // MARK: - Setup buttons
    fileprivate func setup(){
        axis = config.flowDirection
        spacing = config.spacing
        distribution = config.isNarrow ? .fillProportionally : .fillEqually
        for i in 0...config.options.count - 1 {
            let tag = i + 999
            self.tags.append(tag)
            addArrangedSubview(createButton(text:  config.options[i], tag: tag))
        }
    }
    
    /**
    - parameters:
      - text: Inner text of the button
      - tag: Tag refrence for the button
    */
    fileprivate func createButton(text: String, tag: Int) -> SwiftyRadioButtonView {
        let button = SwiftyRadioButtonView()
        button.tag = tag
        button.backgroundColor = config.buttonsBackgroundColor
        button.layer.cornerRadius = config.cornerRaduis
        button.layer.borderColor = config.borderColor.cgColor
        button.layer.borderWidth = config.borderWidth
        button.clipsToBounds = true
        button.text = text
        button.textColor = config.textColor
        button.textAlignment = .center
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:))))
        button.isUserInteractionEnabled = true
        return button
    }
    
    // MARK: Selector functions for taping, touch down & touch up
    @objc fileprivate func tap(_ sender: UITapGestureRecognizer){
        if let view = sender.view {
            toggleButton(tag: view.tag)
        }
    }
    @objc fileprivate func longPress(_ sender: UILongPressGestureRecognizer){
        if let view = sender.view {
            switch sender.state {
            case .began:
                toggleButton(tag: view.tag)
            case .ended:
                toggleButton(tag: view.tag)
            default: break
            }
        }
    }
    
    // MARK: Toggle one button
    fileprivate func toggleButton(tag: Int){
        if let button = viewWithTag(tag) as? SwiftyRadioButtonView {
            if !button.isButtonActive {
                self.delegate?.didSelectRadio(index: tags.firstIndex(of: tag)!, text: button.text!)
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                    button.isButtonActive = true
                    button.textColor = self.config.selectedTextColor
                    button.backgroundColor = self.config.borderColor
                    button.layer.borderColor = self.config.buttonsBackgroundColor.cgColor
                    if !self.config.isMuliple {
                        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                        let otherButtons = self.tags.filter { $0 != button.tag }
                        otherButtons.forEach {
                            if let otherButton = self.viewWithTag($0) as? SwiftyRadioButtonView {
                                otherButton.isButtonActive = false
                                otherButton.textColor = self.config.textColor
                                otherButton.backgroundColor = self.config.buttonsBackgroundColor
                                otherButton.layer.borderColor = self.config.borderColor.cgColor
                                otherButton.transform = .identity
                            }
                        }
                    }
                })
            } else {
                self.delegate?.didDeSelectRadio(index: tags.firstIndex(of: tag)!, text: button.text!)
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                    button.isButtonActive = false
                    button.textColor = self.config.textColor
                    button.backgroundColor = self.config.buttonsBackgroundColor
                    button.layer.borderColor = self.config.borderColor.cgColor
                    button.transform = .identity
                })
            }
        }
    }
}
