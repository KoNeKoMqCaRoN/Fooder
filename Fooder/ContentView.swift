//
//  ContentView.swift
//  Fooder
//
//  Created by cmStudent on 2025/06/23.
//

import SwiftUI

struct Donation: Identifiable {
   let id: String
   let name: String
   let recieved: Bool
   
   var img: Image  {
      switch name {
      case "レタス":
         return Image("retasu")
      case "パン":
         return Image("pan")
      default :
         return Image("retasu")
      }
   }
   
   var statusMessage: String {
      recieved ? "寄付を受け取りました" : "寄付待ちです"
   }
   
   
}


struct ContentView: View {
    @State private var showDonationSheetView: Bool = false
    @State private var showRequestSheetView: Bool = false

   let donataions: [Donation] = [
      Donation(id: UUID().uuidString, name: "レタス", recieved: true),
       Donation(id: UUID().uuidString, name: "トマト", recieved: true),
       Donation(id: UUID().uuidString, name: "牛乳", recieved: false),
       Donation(id: UUID().uuidString, name: "パン", recieved: true),
       Donation(id: UUID().uuidString, name: "卵", recieved: false),
       Donation(id: UUID().uuidString, name: "りんご", recieved: true),
       Donation(id: UUID().uuidString, name: "バナナ", recieved: false),
       Donation(id: UUID().uuidString, name: "お米", recieved: true),
      Donation(id: UUID().uuidString, name: "お米", recieved: true)
   ]
   
   var body: some View {
      //       Spacer()
      
      VStack(alignment: .leading) {
         header
         Divider()
         donateRequestBtn
         Text("最近の寄付")
            .font(.title2)
            .fontWeight(.bold)
            .padding(.top)
         
         donateList
      }
      .fullScreenCover(isPresented: $showRequestSheetView, content: {
          NavigationStack {
              RequestSheetView()
          }
      })
      .fullScreenCover(isPresented: $showDonationSheetView, content: {
          NavigationStack {
              DonationSheetView()
          }
      })
      .padding()
   }
   
}

extension ContentView {
   
   private var header : some View {
      HStack {
         VStack {
            Text("Food Share")
               .font(.title)
               .fontWeight(.bold)
               .frame(maxWidth: 300, alignment: .leading)
               .padding(.bottom, 1)
            
            Text("フードロスを削減しましょう。")
            //                    .font(.title3)
               .frame(maxWidth: 300, alignment: .leading)
               .foregroundColor(.gray)
               .padding(.bottom, 5)
         } // VStack end
         //              Spacer()
         Button {
            // action
         } label: {
            Image(systemName: "bell")
               .resizable()
               .scaledToFit()
               .frame(width: 20)
               .foregroundColor(.black)
         }
      } // HStack end
   }
   
   private var donateRequestBtn : some View {
      HStack {
         Button {
             showDonationSheetView.toggle()
         } label: {
            //                       .LinearGradient(gradient: Gradient(colors: [Color.white,Color.orange]), startPoint: .init(x: 0, y: 0), endPoint: .init(x: 1, y: 1))
            VStack {
               Image(systemName: "mail")
               Text("寄付する")
                  .font(.title3)
                  .fontWeight(.bold)
                  .foregroundStyle(.white)
               Text("余ったものをみんなでシェア")
                  .font(.caption)
                  .foregroundStyle(.white.opacity(0.75))
            } // VStack end
            .padding()
            .frame(width: 165, height: 104)
            .background(.orange)
            .cornerRadius(10)
         }
         
         Spacer()
         
         Button {
             showRequestSheetView.toggle()
         } label: {
            VStack {
               Image(systemName: "magnifyingglass")
               Text("リクエストする")
                  .font(.title3)
                  .fontWeight(.bold)
                  .foregroundStyle(.white)
               Text("必要なものをリクエスト")
                  .font(.caption)
                  .foregroundStyle(.white.opacity(0.75))
            } // VStack end
            .padding()
            .frame(width: 165, height: 104)
            .background(.green)
            .cornerRadius(10)
         } //Button end
         //              .padding()
      } // HStack end
      .padding(.top, 10)
      .padding(.horizontal, 10)
   }
   
   private var donateList : some View {
      List(donataions) { donation in
         donationItemViw(donation: donation)
      }
      .listStyle(.plain)
   }
   
   private func donationItemViw(donation: Donation) -> some View {
      HStack {
         ZStack {
            Rectangle()
               .fill(Color.gray.opacity(0.125))
               .frame(width: 75, height: 75)
               .cornerRadius(7.5)
            donation.img
               .resizable()
               .scaledToFit()
               .frame(width: 15, height: 15)
         }
         VStack {
            Text(donation.name)
               .font(.title3)
               .fontWeight(.bold)
               .frame(maxWidth: 300, alignment: .leading)
               .padding(.bottom, 5)
            Text(donation.statusMessage)
            //                    .font(.title3)
               .frame(maxWidth: 300, alignment: .leading)
               .foregroundColor(.gray)
         }
         .padding(.leading)
      }
   }
}

#Preview {
   ContentView()
}
