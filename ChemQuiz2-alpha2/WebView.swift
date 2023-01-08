//
//  WebView.swift
//  UIParts
//
//  Created by Ryo Hanma on 2021/10/09.
//

import SwiftUI
import WebKit //WebKitをインポート

struct WebView: UIViewRepresentable {
    var path: String = "periodic table" //表示するWEBページのURLを指定

    func makeUIView(context: Context) -> WKWebView{
        return WKWebView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let html = Bundle.main.path(forResource: path, ofType: "html") {
              let url = URL(fileURLWithPath: html)
              let request = URLRequest(url: url)
              uiView.load(request)
        }
    }
}

struct WebViewTest_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
