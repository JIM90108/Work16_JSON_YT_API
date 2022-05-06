//
//  PlayerViewController.swift
//  Work16_JSON_YT_API
//
//  Created by 彭有駿 on 2022/5/5.
//

import UIKit
import AVFoundation
import MediaPlayer
import SpriteKit

private let segueIdentifler = "showMV"

class PlayerViewController:UIViewController {
    
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    
    
    var index: Int!
    
    var YTDataFromPrePage = [YTMusic.Items]()
    
    let player = AVPlayer()
    var playerItem: AVPlayerItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMusicMessage()
//        playMusic()
        
    }
    
    
    @IBSegueAction func showYTMV(_ coder: NSCoder) -> ViewController? {
    return ViewController(coder: coder,YTDataFromPrePage:YTDataFromPrePage,index: index)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func playMusic(){
        let fileMusicUrl = Bundle.main.url(forResource: "https://www.youtube.com/watch?v=\(YTDataFromPrePage[index].contentDetails.videoId)", withExtension:"mp4")!
        playerItem = AVPlayerItem(url:fileMusicUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
    }
    
    
    
    func showMusicMessage(){
        
        URLSession.shared.dataTask(with: YTDataFromPrePage[index].snippet.thumbnails.high.url) {data, response, error in
            if let photo = data {
                DispatchQueue.main.async {
                    self.musicImage.image = UIImage(data: photo)
                }
            }
        }.resume()
        
        self.musicName.text = YTDataFromPrePage[index].snippet.title
        
        
        
    }

}
