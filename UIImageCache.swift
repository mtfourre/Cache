//
//  UIImageCache.swift
//  Cacheable
//
//  Created by Michael Fourre on 10/26/16.
//

import Foundation
import UIKit

public struct UIImageCache: Cacheable
{
    public static var shared: NSCache<NSString, UIImage> = UIImageCache.cache
}
