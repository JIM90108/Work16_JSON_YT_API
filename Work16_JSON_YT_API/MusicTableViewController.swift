//
//  MusicTableViewController.swift
//  Work16_JSON_YT_API
//
//  Created by 彭有駿 on 2022/5/5.
//

import UIKit

private let api = "請輸入你獲得的API"

private let tableIdentifler = "MusicTableViewCell"
private let segueIdentifler2 = "showPlayer"





class MusicTableViewController: UITableViewController {
    
    
    @IBOutlet weak var backgroungImage: UIImageView!
    
    @IBOutlet weak var channelMasterImage: UIImageView!
    
    @IBOutlet weak var channelMasterName: UILabel!
    
    @IBOutlet weak var channelIntroduction: UITextView!
    
    @IBOutlet weak var subscriberLabel: UILabel!
    
    
    //抓取資料
    var musicYTData = [YTMusic.Items]()
    var musicYTPageData : YTPageMessage?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMusicYTData()
        getChannelMessageData()
    }
    
    
    //取得歌曲資訊
    func getMusicYTData(){
        //貼上剛剛歌曲資訊的API
        let urlYTApi = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UU_ol0nA8RUpyRTleAcu8JVw&key=\(api)&maxResults=50"
        
        if let urlString = urlYTApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
            
            if let JSONUrl = URL(string: urlString){
                URLSession.shared.dataTask(with: JSONUrl){ data,response, error in
                    
                    if let date = data{
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        do{
                            let yTsearchResponse = try decoder.decode(YTMusic.self, from: date)
                            self.musicYTData = yTsearchResponse.items
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            print("影片成功")
                        }catch{
                            print(error)
                            print("影片失敗")
                        }
                    }
                    
                }.resume()
            }
            
        }
        
    }
    
    
    //頻道資訊
    func getChannelMessageData(){
        //抓取頻道API
        let urlYTPageApi = "https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,snippet,contentDetails,statistics,status&id=UC_ol0nA8RUpyRTleAcu8JVw&key=\(api)"
        if let urlString = urlYTPageApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let JSONUrl = URL(string: urlString){
                URLSession.shared.dataTask(with: JSONUrl) { data, response, error in
                    if let date = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        do {
                            
                            //嘗試取得資料後將header內的資料透過 self.musicYTPageData來協助顯示
                            let ytPagesearchResponse = try decoder.decode(YTPageMessage.self , from: date)
                            self.musicYTPageData = ytPagesearchResponse
                            DispatchQueue.main.async {
                                URLSession.shared.dataTask(with: (self.musicYTPageData?.items[0].brandingSettings.image.bannerExternalUrl)!) {data, reponse, error in
                                    if let bannerData = data {
                                        DispatchQueue.main.async {
                                            self.backgroungImage.image = UIImage(data: bannerData)
                                        }
                                    }
                                }.resume()
                                URLSession.shared.dataTask(with: (self.musicYTPageData?.items[0].snippet.thumbnails.high.url)!) {data, reponse, error in
                                    if let channelMasterData = data {
                                        DispatchQueue.main.async {
                                            self.channelMasterImage.image = UIImage(data: channelMasterData)
                                        }
                                    }
                                }.resume()
                                self.channelMasterName.text = self.musicYTPageData?.items[0].snippet.title
                                
                                
                                self.channelIntroduction.text = self.musicYTPageData!.items[0].snippet.description
                                
                                let formatter = NumberFormatter()
                                formatter.numberStyle = .decimal
                                formatter.maximumFractionDigits = 0
                                if let intString = Int(self.musicYTPageData!.items[0].statistics.subscriberCount) {
                                    let stringInt = formatter.string(from: NSNumber(value: intString))
                                    self.subscriberLabel.text = "subscriber : \(stringInt!)"
                                }
                            }
                            print("成功")
                        }catch{
                            //若無法do或是失敗列印失敗原因
                            print(error)
                            print("失敗")
                        }
                    }
                }.resume()
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicYTData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifler, for: indexPath) as? MusicTableViewCell else{return UITableViewCell()}
        cell.musicName.text = musicYTData[indexPath.row].snippet.title
        
        URLSession.shared.dataTask(with: musicYTData[indexPath.row].snippet.thumbnails.high.url) {data, response, error in
            if let photo = data {
                DispatchQueue.main.async {
                    cell.musicImageView.image = UIImage(data: photo)
                }
            }
        }.resume()
        //日期指派格式後顯示在publishDateLabel上
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        cell.musicDate.text = dateFormatter.string(from: musicYTData[indexPath.row].snippet.publishedAt)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifler2, sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifler2 {
            if let passMuicMessage = segue.destination as? PlayerViewController{
                
                let selectRow = self.tableView.indexPathForSelectedRow
                if let passIndx = selectRow?.row{
                    passMuicMessage.index = passIndx
                    passMuicMessage.YTDataFromPrePage = musicYTData
                    
                }
                
                
                
            }
        }
    }
}




