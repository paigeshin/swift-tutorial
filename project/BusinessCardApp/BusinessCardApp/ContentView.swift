//
//  ContentView.swift
//  BusinessCardApp
//
//  Created by shin seunghyun on 2020/02/13.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    

    
    var body: some View {
        ZStack {
            Color(red: 0.10, green: 0.74, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                Image("ideal")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150.0, height: 150.0)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                    )
                Text("Shin SeungHyun")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                
                //My answer
//                Text("+44 123 456 789")
//                    .foregroundColor(.black)
//                    .font(.largeTitle).bold()
//                    .padding(15)
//                .background(
//                    RoundedRectangle(cornerRadius: 50).foregroundColor(.white)
//                )
                
                 
                //Instructors Example
                
                InfoView(text: "+44 123 456 789", imageName: "phone.fill")
                InfoView(text: "paige@gmail.com", imageName: "envelope.fill")
            
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

