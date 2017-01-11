//
//  CMUImageView.swift
//  CMUImage
//
//  Created by Camo_u on 2017. 1. 11..
//  Copyright © 2017년 Camo_u. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView
{
    func loadImage(fromURL url:String, placeholder:UIImage? = nil, onComplete closure:((Data?)->Void)? = nil)
    {
        //setting placeholder
        if let placeholder = placeholder {
            self.placeholder = placeholder
        }
        
        //caheing image at local
        if let cached = CMUCache.load(key: url) as! Data? {
            self.image = UIImage(data: cached)
            return
        }
        
        //progressing circle
        var progressCircle = CAShapeLayer()
        var rect = CGRect(x: 0, y: 0, width: 30, height: 30)
        rect.origin.x = self.bounds.width/2 - rect.width/2
        rect.origin.y = self.bounds.height/2 - rect.height/2
        let circlePath = UIBezierPath(ovalIn: rect)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.white.cgColor
        progressCircle.strokeEnd = 0
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 3.0
        
        self.layer.addSublayer(progressCircle)
        
        //downloading with alamofire
        Alamofire.request(url).downloadProgress { progress in
            progressCircle.strokeEnd = CGFloat(progress.fractionCompleted)
            }.responseData { response in
                progressCircle.removeFromSuperlayer()
                if let data = response.result.value {
                    self.image = self.cropCenter(image:UIImage(data: data)!)
                    CMUCache.save(UIImagePNGRepresentation(self.image!), with: url)
                    closure?(data)
                }
        }
    }
    
    @IBInspectable public var placeholder:UIImage {
        set(value) {
            guard self.image == nil else { return; }
            self.image = value
        }
        get {
            return self.placeholder
        }
    }
    
    private func cropCenter(image:UIImage) -> UIImage? {
        var sizeRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let sizeRatio:CGSize = CGSize(width: self.bounds.width / image.size.width,
                                      height: self.bounds.height / image.size.height)
        if sizeRatio.width == sizeRatio.height { return image }
        else if sizeRatio.width > sizeRatio.height {
            sizeRect.size.height = self.bounds.height / sizeRatio.width
            sizeRect.origin.y = (image.size.height - sizeRect.height) / 2
        }
        else {
            sizeRect.size.width = self.bounds.width / sizeRatio.height
            sizeRect.origin.x = (image.size.width - sizeRect.width) / 2
        }
        
        let imageRef:CGImage = image.cgImage!.cropping(to: sizeRect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
}
