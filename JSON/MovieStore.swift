//
//  MovieStore.swift
//  JSON
//
//  Created by 佐藤一成 on 2020/10/06.
//

import Foundation

struct MovieResponse:Decodable{
    let movies:[Movie]
    let response:String
    private enum CodingKeys: String, CodingKey{
        case movies = "Search"
        case response = "Response"
    }
}


struct Movie: Decodable{
    let imdbID:String
    let title:String
    let poster:String
    
    private enum CodingKeys: String, CodingKey{
        case imdbID
        case title = "Title"
        case poster = "Poster"
    }
}


class MovieStore:ObservableObject{
    @Published var movies:[Movie]? = [Movie]()
    
    func changeSearchString(searchString:String){
        self.getAll(searchString: searchString)
    }
    
    init(){
        print("init")
        self.getAll()
    }
    
    func getAll(searchString:String = ""){
        self.movies?.removeAll()
        let urlString:String = "http://www.omdbapi.com/?apikey=dfd99a49" + (searchString == "" ? "":"&s=\(searchString)")
        print(urlString)
            guard let url = URL(string: urlString) else{
            fatalError("Invalid URL")
        }
        URLSession.shared.dataTask(with: url){data, response,error in
            guard let data = data, error == nil else{
                return
            }
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self,from:data)
            if let movieResponse = movieResponse{
                DispatchQueue.main.async {
                    
                    self.movies = movieResponse.movies
                }
                
            }
        }.resume()
        
    }
    
}
