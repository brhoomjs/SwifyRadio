//
//  SwiftyRadio+Config.swift
//  SwiftyRadio
//
//  Created by Ibrahim F on 31/05/2020.
//

import UIKit

class SwiftyRadioConfig {
    // MARK: - Config variables section
    /// Set buttons corner raduis
    public var cornerRaduis: CGFloat = 5.0
    /// Set buttons border color
    public var borderColor: UIColor = UIApplication.shared.windows.first?.tintColor ?? .systemBlue
    /// Set buttons border width
    public var borderWidth: CGFloat = 2
    /// Set buttons background color
    public var buttonsBackgroundColor: UIColor = .systemBackground
    /// Set buttons text color
    public var textColor: UIColor = UIApplication.shared.windows.first?.tintColor ?? .systemBlue
    /// Set selected buttons text color
    public var selectedTextColor: UIColor = .systemBackground
    /// Set buttons flow direction: horizontal or vertical
    public var flowDirection: NSLayoutConstraint.Axis = .horizontal
    /// Set spacing between buttons
    public var spacing: CGFloat = 10
    /// Set Buttons text array
    public var options: [String] = []
    /// Set if buttons are equal width or narrow
    public var isNarrow: Bool = false
    /// Set if user can select muliple buttons
    public var isMuliple: Bool = false
}
