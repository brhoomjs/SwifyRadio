//
//  SwiftyRadio+Delegate.swift
//  SwiftyRadio
//
//  Created by Ibrahim F on 31/05/2020.
//

import Foundation

protocol SwiftyRadioButtonsDelegate{
    func didSelectRadio(index: Int, text: String)
    func didDeSelectRadio(index: Int, text: String)
}
