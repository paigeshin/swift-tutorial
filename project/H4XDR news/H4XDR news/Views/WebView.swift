//
//  WebView.swift
//  H4XDR news
//
//  Created by shin seunghyun on 2020/02/14.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation
import WebKit
import SwiftUI

//WebView
struct WebView : UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
            
        }
    }
}
