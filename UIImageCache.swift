//
//  UIImageCache.swift
//
//  Created by Michael Fourre on 10/26/16.
//

import Foundation
import UIKit

struct UIImageCache: Cacheable
{
    static var shared: NSCache<NSString, UIImage> = UIImageCache.cache
}
