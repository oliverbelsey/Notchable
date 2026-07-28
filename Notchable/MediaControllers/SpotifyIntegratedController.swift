//
//  SpotifyIntegratedController.swift
//  Notchable
//
//  Created by Oliver Belsey on 15/07/2026.
//

import SwiftUI
import WebKit
import MediaPlayer

struct SpotifyWebView: NSViewRepresentable {
    @Binding var mediaData: MediaData
    class Coordinator: NSObject, WKScriptMessageHandler {
        var parent: SpotifyWebView
        init(parent: SpotifyWebView) {
            self.parent = parent
        }
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            guard message.name == "spotifyHandler" else { return }
            if let body = message.body as? [String: Any] {
            }
        }
    }
    func makeNSView(context: Context) -> some NSView {
        var webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsAirPlayForMediaPlayback = true
        webConfiguration.userContentController.add(context.coordinator, name: "spotifyHandler")
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.load(URLRequest(url: URL(filePath: "")))
        return view
    }
    func updateNSView(_ nsView: NSViewType, context: Context) {
    }
}

class SpotifyIntegratedController: MediaControllerProtocol {
}
