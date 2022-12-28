//
//  DetailViewController.swift
//  Map Pins
//
//  Created by n on 04.10.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
//MARK: - properties
    var selectedCapital: Capital!
    var webView: WKWebView!

//MARK: - loadView
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://en.wikipedia.org/wiki/" + selectedCapital.wikiData)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
