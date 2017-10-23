//
//  UIImageView+Load.swift
//  facebook-auth
//
//  Created by Vladimir Tymishak on 23.10.17.
//  Copyright © 2017 own. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(from urlString: String?) {
        guard
            let urlString = urlString,
            let url = URL(string: urlString) else {
                return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                print("Failed to load image: \(error!.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty image data.")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
