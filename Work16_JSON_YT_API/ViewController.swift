//
//  ViewController.swift
//  Work16_JSON_YT_API
//
//  Created by 彭有駿 on 2022/5/5.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    var YTDataFromPrePage = [YTMusic.Items]()
    var index:Int
    
    init?(coder: NSCoder, YTDataFromPrePage: [YTMusic.Items],index:Int) {
        self.YTDataFromPrePage = YTDataFromPrePage
        self.index = index
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlToWatch = "https://www.youtube.com/watch?v=\(YTDataFromPrePage[index].contentDetails.videoId)"
        if let url = URL(string: urlToWatch) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        
        
    }


}

