//
//  MapView.swift
//  Sketch Weather
//
//  Created by user on 5/15/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import WebKit
import UIKit


class MapView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadHTMLString("<script src='https://darksky.net/map-embed/@temperature,26.927,-95.141,3.js?embed=true&timeControl=false&fieldControl=true&defaultField=temperature&defaultUnits=_f'></script>", baseURL: nil)
        
        
    }
    
    
    
    
    
    
    
    
}
