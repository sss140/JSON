//
//  ContentView.swift
//  JSON
//
//  Created by 佐藤一成 on 2020/10/06.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var store:MovieStore
    @State var searchString:String = ""
    
    let columns:[GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
            NavigationView{
                VStack{
                    
                    TextField("StringProtocol", text: $searchString
                              , onCommit: {
                                let sendString:String = searchString.replacingOccurrences(of: " ", with: "")
                                
                                self.store.changeSearchString(searchString: sendString)
                              })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                ScrollView{
                    LazyVGrid(columns:columns){
                        ForEach(store.movies ?? [Movie](), id:\.imdbID){ movie in
                            NavigationLink(destination: Text(movie.title)){
                                VStack{
                                    URLImage(url: movie.poster)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 150)
                                    Text(movie.title)
                                        .frame(maxHeight:.infinity,alignment:.top)
                                }
                            }
                        }
                    }
                    /*.onAppear{
                     store.getAll()
                     }*/
                }.navigationTitle("Movies")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store:MovieStore())
    }
}
