//
//  UIImage+adds.swift
//  IBMWeather
//
//  Created by Mac on 13.06.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizedImage(for size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
}
