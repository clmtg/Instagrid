//
//  UIView+Image.swift
//  Instagrid
//
//  Created by Clément Garcia on 10/11/2021.
//

import UIKit

extension UIView {

    var image: UIImage {
            let renderer = UIGraphicsImageRenderer(size: bounds.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
    }
}
