//
//  MainTabView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/01.
//

import SwiftUI

struct MainTabView: View {
   
   @State var selectedTab: Int = 1
   
   
    var body: some View {
       TabView(selection: $selectedTab) {
          HomeView()
             .tag(0)
             .tabItem {
                VStack {
                   Image(systemName: "house.fill")
                   Text("ホーム")
                }
                             }
          
          
          Text("Map View")
             .tag(1)
             .tabItem {
                VStack {
                   Image(systemName: "map")
                   Text("マップ")
                }
             }
          
          Text("kifu View")
             .tag(2)
             .tabItem {
                VStack {
                   Image(systemName: "list.bullet.clipboard.fill")
                   Text("寄付一覧")
                }
             }
          
          Text("request View")
             .tag(3)
             .tabItem {
                VStack {
                   Image(systemName: "list.bullet")
                   Text("リクエスト一覧")
                }
             }

       }
       .tint(.red)
    }
}

#Preview {
    MainTabView()
}
