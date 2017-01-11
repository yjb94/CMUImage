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
    func loadImage(fromURL url:String)
    {
        if let cached = CMUCache.load(key: url) as! Data? {
            self.image = UIImage(data: cached)
        }
        
        Alamofire.request(url).response { responses in
            if responses.error != nil {
                print(responses.error!)
                return
            }
            
            guard let data = responses.data else { return }
            self.image = UIImage(data: data)
//                CMUCache.save(data, with: url)
        }
    }
}
