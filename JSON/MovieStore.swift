//
//  MovieStore.swift
//  JSON
//
//  Created by 佐藤一成 on 2020/10/06.
//

import Foundation

struct MovieResponse:Decodable{
    let movies:[Movie]?
    let totalResults:String?
    let response:String
    let error:String?
    private enum CodingKeys: String, CodingKey{
        case movies = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}


struct Movie: Decodable{
    let imdbID:String
    let title:String
    let poster:String
    let year:String
    let type:String
    
    private enum CodingKeys: String, CodingKey{
        case imdbID
        case title = "Title"
        case poster = "Poster"
        case year = "Year"
        case type = "Type"
    }
}


class MovieStore:ObservableObject{
    @Published var movies:[Movie]? = [Movie]()
    @Published var navigationTitle = "Movies"
    func changeSearchString(searchString:String){
        self.getAll(searchString: searchString)
    }
    
    init(){
        self.getAll()
    }
    
    func getAll(searchString:String = ""){
        self.navigationTitle = "Requesting..."
        self.movies?.removeAll()
        let urlString:String = "http://www.omdbapi.com/?apikey=dfd99a49" + (searchString == "" ? "":"&s=\(searchString)")
            guard let url = URL(string: urlString) else{
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url){data, response,error in
            guard let data = data, error == nil else{
                return
            }
            let movieResponse = try? JSONDecoder().decode(MovieResponse.self,from:data)
            if let movieResponse = movieResponse{
                print(movieResponse)
                DispatchQueue.main.async {
                    self.movies = movieResponse.movies
                    if movieResponse.response == "True"{
                        self.navigationTitle = searchString + "(\(movieResponse.totalResults!))"
                    }else{
                        self.navigationTitle = movieResponse.error!
                    }
                }
            }
        }.resume()
        
    }
    
}
