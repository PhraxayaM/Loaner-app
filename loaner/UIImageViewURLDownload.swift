//
//  UIImageViewURLDownload.swift
//  loaner
//
//  Created by MattHew Phraxayavong on 5/12/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import Foundation
import UIKit.UIImageView

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageDownloaded"), object: nil)
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
