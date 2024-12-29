//
//  OzelImage.swift
//  MovieLists
//
//  Created by doğan güneş on 28.12.2024.
//

import SwiftUI

struct OzelImage: View {
    
    
    let url : String
    @ObservedObject var imageDownloaderClient = ImageDownloaderClient()
    
    init(url:String) {
        self.url = url
        self.imageDownloaderClient.gorselIndir(url: self.url)
    }
    
    
    
    var body: some View {
        if let data = self.imageDownloaderClient.indirilenGorsel {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        } else {
            return Image("Pikachu")
                .resizable()
        }
    }
}

#Preview {
    OzelImage(url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFYRSUCQugPqhwxJeCO9Pk32BJDzg2zl_KYw&s")
}
