import Foundation   
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, NSData>()
//    let user = Auth.auth().currentUser
//    
//    func downloadImage(completion: @escaping (Result<Data, Error>) -> Void) {
//        guard let photoUrl = user?.photoURL else { return }
//        
//        let cacheKey = photoUrl.absoluteString as NSString
//        if let data = cache.object(forKey: cacheKey) {
//            completion(.success(data as Data))
//        }
//        
//        guard let url = URL(string: photoUrl.absoluteString) else { return }
//        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
//            if error != nil { return }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//            guard let data = data else { return }
//            
//            self!.cache.setObject(data as NSData, forKey: cacheKey)
//            
//            completion(.success(data))
//        }
//        
//        task.resume()
//    }
}
