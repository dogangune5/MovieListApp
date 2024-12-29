//
//  Film.swift
//  MovieLists
//
//  Created by doğan güneş on 28.12.2024.
//

import Foundation



// Bu yapı, bir film API'sinden alınan JSON formatındaki verileri kolayca kullanabilmek için Codable protokolü ile birlikte kullanılır. Örneğin, bir API'den film bilgileri JSON formatında alınır ve bu bilgiler Swift dilinde anlamlı yapılar olan Film yapısına dönüştürülür. Aynı şekilde, bir Film yapısı JSON formatına dönüştürülebilir ve bir API'ye gönderilebilir.

struct Film : Codable {
    let title : String
    let year : String
    let imdbId : String
    let type : String
    let poster : String
    
        
    private enum CodingKeys: String,CodingKey {
        
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
    
}

struct GelenFilmler: Codable {
    
    /// "Film" yapısındaki filmlerin bir dizisini tutar
    let filmler: [Film]
    
    /// JSON'daki anahtarları Swift değişkenleriyle eşleştirmek için CodingKeys enum'u kullanılır
    private enum CodingKeys: String, CodingKey {
        /// JSON'daki "Search" anahtarını "filmler" değişkenine eşler
        case filmler = "Search"
    }
}
