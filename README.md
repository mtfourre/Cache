# Cacheable
Simple protocol wrapper for NSCache interaction with basic support for some common native Swift key types.

This protocol can be adopted by any class or struct which implements the static `shared` property which defines the key/value type of the cache. Interaction with the cache can then be performed by invoking methods on the class metatype or directly on the class itself. For example, the included `UIImageCache` struct can be used in the following way:

    // Declare UIImageCache struct which adopts the Cacheable protocol
    struct UIImageCache: Cacheable
    {
        // Define a "shared" property of type NSCache with key type NSString and value type UIImage
        static var shared: NSCache<NSString, UIImage> = UIImageCache.cache
    }
    
    let image = UIImage(named: "image") // Get an instance of UIImage
    UIImageCache.put(image, at: "key") // Put the image in the cache at key "key"
    let storedImage = UIImageCache.get("key") // Get the image back from the cache using the same key "key"

With this implementation, the `UIImageCache` declaration can exist anywhere in a project and can be referenced globally to retrieve stored objects in the shared cache. In this way, it could be possible to define unique caches with different or equivalent types if one wishes to keep some objects in separate caches. For example, the following would be valid:

    struct UIImageCache: Cacheable
    {
        static var shared: NSCache<NSString, UIImage> = UIImageCache.cache
    }
    
    struct AnotherUIImageCache: Cacheable
    {
        static var shared: NSCache<NSString, UIImage> = AnotherUIImageCache.cache
    }
    
    let image = UIImage(named: "image")
    UIImageCache.put(image, at: "key")
    let anotherImage = AnotherUIImageCache.get("key") // Returns nil since this is a different cache

Then of course, something like this would also be perfectly valid:

    struct UIImageCache: Cacheable // Cache for storing UIImage with key type NSString
    {
        static var shared: NSCache<NSString, UIImage> = UIImageCache.cache
    }
    
    struct NSDataCache: Cacheable // Cache for storing NSData with key type NSString
    {
        static var shared: NSCache<NSString, NSData> = NSDataCache.cache
    }
    
    let image = UIImage(named: "image")
    UIImageCache.put(image, at: "key")
    let storedImage = UIImageCache.get("key")
    
    let data = NSData(contentsOf: URL(string: "http://lorempixel.com/400/200/")!)
    NSDataCache.put(data, at: "key")
    let storedData = NSDataCache.get("key")

The `Cacheable` protocol can be extended, providing convenience functions which wrap around the (ugly) `NSFoundation` types to instead use native Swift types. Already included are two extensions for `Cacheable`s which have keys with the Swift types of `String` or `Int`. Additional extensions could be added:

    extension Cacheable where K: NSString, V: NSData
    {
        static func get(_ key: String?) -> Data?
        {
            let key = K(string: key ?? "")
            guard let data = self.get(key) else { return nil }
            return Data(referencing: data)
        }
    
        static func put(_ object: Data?, at key: String?)
        {
            guard let data = object else { return }
            self.put(V(data: object), at: K(string: key ?? ""))
        }
    }

Please report any issues with this reference here on Github so that I can tend to them ASAP.
