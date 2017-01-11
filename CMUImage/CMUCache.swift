//
//  CMUCache.swift
//
//  Created by Camo_u on 2017. 1. 11..
//  Copyright © 2017년 Camo_u. All rights reserved.
//

import UIKit

class CMUCache: Any
{
    class func save(_ data:Any?, with key:String)
    {
        UserDefaults.standard.set(data, forKey: key)
    }
    class func load(key:String) -> Any?
    {
        guard let data = UserDefaults.standard.object(forKey: key) else { return nil }
        return data
    }
}
