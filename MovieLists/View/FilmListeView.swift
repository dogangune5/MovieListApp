//
//  ContentView.swift
//  MovieLists
//
//  Created by doğan güneş on 28.12.2024.
//

import SwiftUI

struct FilmListeView: View {
    
    @ObservedObject var filmListeViewModel: FilmListeViewModel
    @State var aranacakFilm = ""
    
    init() {
        self.filmListeViewModel = FilmListeViewModel()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arka plan rengi
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Arama alanı
                    TextField("Aranacak Film", text: $aranacakFilm, onCommit: {
                        self.filmListeViewModel.filmAramasiYap(filmIsmi: aranacakFilm.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? aranacakFilm)
                    })
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .background(Color.white)  // Arka plan rengi
                    .cornerRadius(10)
                    .shadow(radius: 5)  // Gölgeli kutu efekti
                    .padding([.leading, .trailing, .top], 20)  // Yatayda ve yukarıda boşluk
                    
                    // Film listesi
                    List(filmListeViewModel.filmler, id: \.imdbId) { film in
                        NavigationLink(
                            destination: DetayView(imdbId: film.imdbId),
                            label: {
                                HStack(alignment: .top, spacing: 20) {  // Daha fazla boşluk için spacing
                                    // Film posteri
                                    OzelImage(url: film.poster)
                                        .frame(width: 80, height: 120)
                                        .cornerRadius(10)  // Köşeleri yuvarlat
                                        .shadow(radius: 5)  // Hafif gölge efekti
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        // Film başlığı
                                        Text(film.title)
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        
                                        // Ayırıcı çizgi
                                        Divider()
                                            .background(Color.gray)
                                        
                                        // Film yılı
                                        Text(film.year)
                                            .font(.subheadline)
                                            .foregroundColor(.orange)
                                        
                                        
                                    }
                                    .padding(.vertical, 8)  // Dikeyde boşluk
                                }
                                .padding(.vertical, 8)  // Her öğenin üstüne ve altına boşluk
                            })
                            .listRowBackground(Color.clear)  // Arka plan şeffaf
                    }
                    .listStyle(PlainListStyle())  // Basit liste stili
                    .background(Color.clear)  // Arka plan şeffaf
                    .navigationTitle("Movies")
                    .padding([.leading, .trailing, .bottom], 10)
                }
            }
        }
    }
}

#Preview {
    FilmListeView()
}
