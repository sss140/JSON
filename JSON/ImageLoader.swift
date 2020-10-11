//
//  ImageLoader.swift
//  JSON
//
//  Created by 佐藤一成 on 2020/10/07.
//

import Foundation

class ImageLoader:ObservableObject{
    
    @Published var downloadedData: Data?
    
    func downloadImage(url:String){
        guard let imageURL = URL(string: url)else{
            return
        }
        URLSession.shared.dataTask(with:imageURL){data,response,error in
            guard let data = data,error == nil else{
                return
            }
            DispatchQueue.main.async {
                self.downloadedData = data
            }
        }.resume()
    }
    
}
