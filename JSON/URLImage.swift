//
//  URLImage.swift
//  JSON
//
//  Created by 佐藤一成 on 2020/10/07.
//

import SwiftUI

struct URLImage: View {
    //let url:String
    //let placeholder:String
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url:String){
        //self.url = url
        //self.placeholder = placeholder
        self.imageLoader.downloadImage(url: url)
    }
    var body: some View {
        if let data = self.imageLoader.downloadedData{
             Image(uiImage: UIImage(data: data)!).renderingMode(.original).resizable()
        }else{
             Image(systemName: "icloud.slash")
                .renderingMode(.original).resizable()
        }
    }
}
/*
struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage()
    }
}
 */
