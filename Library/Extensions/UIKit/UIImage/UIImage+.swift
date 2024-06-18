//
//  UIImage+.swift
//  Library
//
//  Created by Wael Saad on 4/5/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Photos

extension UIImage {
    
    convenience init?(contentsOf url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }
    
    func saveImage() {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        } completionHandler: { success, error in
            if success {
                print("Screenshot saved to Photos library.")
            } else if let error = error {
                print("Error saving screenshot: \(error)")
            }
        }
    }
    
    static func getImageGradient(topColor: UIColor, bottomColor: UIColor) -> UIImage {
        let imageRenderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
        return imageRenderer.image { ctx in
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = imageRenderer.format.bounds
            gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
            // gradientLayer.locations = [0, 1]
            gradientLayer.locations = [0, 0.5]
            // gradientLayer.locations = [0, 0.5, 1]
            gradientLayer.startPoint = .zero
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.render(in: ctx.cgContext)
        }
    }
    
}
