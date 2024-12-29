//
//  DetayView.swift
//  MovieLists
//
//  Created by doğan güneş on 29.12.2024.
//

import SwiftUI

struct DetayView: View {
    
    let imdbId: String
    
    @ObservedObject var filmDetayViewModel = FilmDetayViewModel()
    
    var body: some View {
        ZStack {  // Arka plan ile kartı ZStack içinde ayırıyoruz
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)  // Arka plan tüm ekranı kaplasın
            
            ScrollView {  // Tüm içeriği kaydırılabilir hale getir
                VStack {
                    Spacer()  // Üstte boşluk bırak
                    
                    VStack(spacing: 20) {  // Daha fazla boşluk ekleyelim
                        // Film Posteri
                        OzelImage(url: filmDetayViewModel.filmDetayi?.poster ?? "")
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.4)
                            .cornerRadius(20)  // Köşeleri yuvarlat
                            .shadow(radius: 10)  // Hafif gölge ver
                            .padding(.top, 20)  // Yukarıdan boşluk bırak
                        
                        // Film Başlığı
                        Text(filmDetayViewModel.filmDetayi?.title ?? "Film ismi Gösterilicek")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing], 10)
                        
                        // Film Özeti (Plot)
                        Text(filmDetayViewModel.filmDetayi?.plot ?? "Plot gösterilicek")
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing], 20)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)  // Satır limiti olmadan tüm plotu göster
                        
                        // Yönetmen
                        InfoRow(title: "Yönetmen", value: filmDetayViewModel.filmDetayi?.director ?? "Yönetmen adı Gösterilicek")
                        
                        // Yazar
                        InfoRow(title: "Yazar", value: filmDetayViewModel.filmDetayi?.writer ?? "Yazar adı Gösterilicek")
                        
                        // Yıl
                        InfoRow(title: "Yıl", value: filmDetayViewModel.filmDetayi?.year ?? "Yıl Gösterilicek")
                        
                        // Ödüller
                        InfoRow(title: "Ödüller", value: filmDetayViewModel.filmDetayi?.awards ?? "Ödüller Gösterilicek")
                    }
                    .padding()  // Tüm içeriğe kenar boşluğu ekleyelim
                    .background(Color(.systemGray6))  // Hafif gri arka plan rengi
                    .cornerRadius(20)
                    .shadow(radius: 10)  // Kart tarzında gölge efekti
                    .padding()
                    
                    Spacer()  // Altta boşluk bırak
                }
            }
        }
        .onAppear {
            self.filmDetayViewModel.filmDetayiAl(imdbId: imdbId)
        }
    }
}

struct InfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.brown)
            
            Text(value)
                .font(.system(size: 18))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, alignment: .leading)  // Sol tarafa hizala
    }
}
#Preview {
    DetayView(imdbId: "Test")
}
