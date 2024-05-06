//
//  NSString+Extension.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import Foundation
import UIKit

extension NSString {
    
    func textSize(font : UIFont?)-> CGSize {
        if let font = font {
           let fontAttributes = [NSAttributedString.Key.font: font]
           let text = self
           let size = text.size(withAttributes: fontAttributes)
            return size
        } else {
            return .zero
        }
    }
}
