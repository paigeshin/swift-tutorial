//
//  InfoView.swift
//  BusinessCardApp
//
//  Created by shin seunghyun on 2020/02/13.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                Text(text).foregroundColor(.black)
            })
            .padding(.all)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "+44 123 456 789", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
