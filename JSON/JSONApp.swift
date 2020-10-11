//
//  JSONApp.swift
//  JSON
//
//  Created by 佐藤一成 on 2020/10/06.
//

import SwiftUI

@main
struct JSONApp: App {
    
    @StateObject var store = MovieStore()
    
    var body: some Scene {
        WindowGroup{
            ContentView(store:store)
        }
    }
}

