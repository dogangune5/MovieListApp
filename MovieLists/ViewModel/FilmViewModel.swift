//
//  FilmViewModel.swift
//  MovieLists
//
//  Created by doğan güneş on 28.12.2024.
//


// FİLMLERİ BURADAN ÇEKECEĞİZ

import Foundation
import SwiftUI

// Film aramalarını yönetmek için kullanılan ViewModel

class FilmListeViewModel : ObservableObject {
    
    // Filmler dizisi; her değiştiğinde SwiftUI arayüzünü otomatik günceller
    
    @Published var filmler = [FilmViewModel]()
    
    // DownloaderClient, filmleri API'den indiren sınıf
    
    let downloaderClient = DownloaderClient()
    
    // Film araması yapmak için kullanılan fonksiyon
    
    func filmAramasiYap(filmIsmi: String) {
        
        // DownloaderClient sınıfı ile API'den film araması yapıyoruz
        
        downloaderClient.filmleriIndir(search: filmIsmi) { sonuc in
            
            // Arama sonucuna göre switch ile iki durum yönetiyoruz
            
            switch sonuc {
            case .failure(let hata):
                
                // Eğer bir hata oluşursa konsola yazdırılıyor
                
                print(hata)
                
            case .success(let filmDizisi):
                
                // Başarılı durumda, indirilen filmleri işliyoruz
                
                if let filmDizisi = filmDizisi {
                    
                    // Main thread'de arayüzü güncellemek için DispatchQueue kullanıyoruz
                    
                    DispatchQueue.main.async {
                        
                        // İndirilen Film nesnelerini FilmViewModel'e dönüştürüp filmler dizisine atıyoruz
                        
                        self.filmler = filmDizisi.map(FilmViewModel.init)
                    }
                }
            }
        }
    }
}


// kullanıcaya neler göstereceğimizi burada belirliyoruz

struct FilmViewModel {
    let film : Film
    
    var title : String {
        film.title
    }
    
    var poster : String {
        film.poster
    }
    
    var year : String {
        film.year
    }
    
    var imdbId : String {
        film.imdbId
    }
    
}
