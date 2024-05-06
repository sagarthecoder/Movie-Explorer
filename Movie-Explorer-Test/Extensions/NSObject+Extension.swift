//
//  NSObject+Extension.swift
//  Movie-Explorer-Test
//
//  Created by Sagar on 5/7/24.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: self)
    }
    
    public class var className: String {
        return String(describing: self)
    }
}
