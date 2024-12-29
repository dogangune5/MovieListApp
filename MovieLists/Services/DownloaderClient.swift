//
//  DownloaderClient.swift
//  MovieLists
//
//  Created by doğan güneş on 28.12.2024.
//

import Foundation


// Film indirme işlemlerini gerçekleştiren sınıf
class DownloaderClient {
    
    // Filmleri indiren fonksiyon. `search` parametresiyle API'ye gönderilecek arama terimi belirtilir.
    // İndirilen veriler, tamamlandığında bir completion bloğu ile döndürülür.
    
    func filmleriIndir(search: String, completion: @escaping (Result<[Film]?, DownloaderError>) -> Void) {
        
        // Geçerli bir URL oluşturuluyor. Eğer URL yanlışsa, `yanlisUrl` hatası döndürülür.
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=9b7d1fa") else {
            return completion(.failure(DownloaderError.yanlisUrl))
        }
        
        // URLSession kullanarak bir veri indirme işlemi başlatılır.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Eğer veriler gelmezse veya bir hata oluşursa, `veriGelmedi` hatası döndürülür.
            guard let data = data, error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            
            // Gelen JSON verisi `GelenFilmler` yapısına çözülmeye (decode) çalışılır.
            // Eğer bu işlem başarısız olursa, `veriIslenemedi` hatası döndürülür.
            guard let filmCevabi = try? JSONDecoder().decode(GelenFilmler.self, from: data) else {
                return completion(.failure(.veriIslenemedi))
            }
            
            // Eğer her şey başarılıysa, filmler dizisi (filmCevabi.filmler) başarıyla completion'a döndürülür.
            completion(.success(filmCevabi.filmler))
            
        }.resume() // Veri indirme işlemi başlatılır.
    }
    
    
    
    func filmDetayiniIndir(imdbId: String, completion: @escaping (Result<FilmDetay,DownloaderError>) -> Void) {
        
        
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=9b7d1fa") else {
            return completion(.failure(DownloaderError.yanlisUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data,response,error) in
            
            guard let data = data , error == nil else {
                return completion(.failure(.veriGelmedi))
            }
            
            guard let gelenFilmDetayi = try? JSONDecoder().decode(FilmDetay.self, from: data) else {
                return completion(.failure(.veriIslenemedi))
            }
            
            completion(.success(gelenFilmDetayi))
            
            
        }.resume()
        
    }
    
    
    
}

// İndirme sırasında oluşabilecek hataları tanımlayan bir enum
enum DownloaderError: Error {
    case yanlisUrl // Yanlış bir URL girildiğinde oluşur
    case veriGelmedi // Veri indirilirken bir sorun olduğunda oluşur (örneğin, internet bağlantısı yoksa)
    case veriIslenemedi // Veri başarıyla indirilse bile JSON'a çözülemediğinde oluşur
}
